import { UltraHonkBackend } from "@aztec/bb.js";
import { Noir } from "@noir-lang/noir_js";
import circuit from "./target/circuit.json";

const show = (id, content) => {
  const container = document.getElementById(id);
  container.appendChild(document.createTextNode(content));
  container.appendChild(document.createElement("br"));
};

document.getElementById("submit").addEventListener("click", async () => {
  try {
    const birth_year = document.getElementById("birth_year").value;
    
    const noir = new Noir(circuit);
    const backend = new UltraHonkBackend(circuit.bytecode);

    show("logs", "Generating witness... ⏳");
    const { witness } = await noir.execute({ birth_year, current_year: 2025 });
    show("logs", "Generated witness... ✅");

    show("logs", "Generating proof... ⏳");
    const proof = await backend.generateProof(witness);
    show("logs", "Generated proof... ✅");
    show("results", proof.proof);

    show("logs", "Verifying proof... ⌛");
    const isValid = await backend.verifyProof(proof);
    show("logs", `Proof is ${isValid ? "valid" : "invalid"}... ✅`);
  } catch {
    show("logs", "Oh 💔");
  }
});
