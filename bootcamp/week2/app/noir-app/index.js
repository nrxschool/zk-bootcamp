const show = (id, content) => {
  const container = document.getElementById(id);
  container.appendChild(document.createTextNode(content));
  container.appendChild(document.createElement("br"));
};

const importAll = async () => {
  const { UltraPlonkBackend } = await import("@aztec/bb.js");
  const { Noir } = await import("@noir-lang/noir_js");
  const circuit = await import("./target/circuit.json");

  return {
    UltraPlonkBackend,
    Noir,
    circuit,
  };
};

const generateWitness = async (noir, birth_year) => {
  show("logs", "Generating witness... ⏳");
  const { witness } = await noir.execute({ birth_year, current_year: 2025 });
  show("logs", "Generated witness... ✅");
  return witness;
};

const generateProof = async (backend, witness) => {
  show("logs", "Generating proof... ⏳");
  const proof = await backend.generateProof(witness);
  show("logs", "Generated proof... ✅");
  show("results", proof.proof);
  return proof;
};

const verifyProof = async (backend, proof) => {
  show("logs", "Verifying proof... ⌛");
  const isValid = await backend.verifyProof(proof);
  show("logs", `Proof is ${isValid ? "valid" : "invalid"}... ✅`);
  return { proof, isValid };
};

document.getElementById("submit").addEventListener("click", async () => {
  try {
    const libs = await importAll();
    const birth_year = document.getElementById("birth_year").value;

    const noir = new libs.Noir(libs.circuit);
    const backend = new libs.UltraPlonkBackend(libs.circuit.bytecode);

    const witness = await generateWitness(noir, birth_year);
    const proof = await generateProof(backend, witness);

    console.log("typeof proof:", typeof(proof))
    console.log("show proof:", proof)
    
    await verifyProof(backend, proof);
    const vk = await backend.getVerificationKey();
    console.log("show vk:", vk)

    // send ( proof, vk ) to backend
    try {
      const response = await fetch("http://localhost:3030/verify", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          public_inputs: proof.publicInputs[0],
          proof: proof.proof,
          vk: vk,
        }),
      });

      const data = await response.json();
      if (data.success) {
        show("logs", "✅ Proof verified and sent to server successfully!");
      } else {
        show("logs", "❌ Server verification failed");
      }
    } catch (error) {
      show("logs", "❌ Error sending proof to server");
      console.error(error);
    }
  } catch (error) {
    show("logs", "Oh 💔 (see logs)");
    console.error(error);
  }
});
