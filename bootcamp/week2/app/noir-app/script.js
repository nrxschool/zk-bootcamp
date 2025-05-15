#!/usr/bin/env node
/*
  Node.js script to generate a Noir UltraPlonk proof and verify it locally and on zkVerify (Volta testnet).
  Usage:
    1) Add "type": "module" to your package.json to silence warnings.
    2) Install dependencies: npm install @aztec/bb.js @noir-lang/noir_js zkverifyjs buffer
    3) Run: node script.js <birth_year>
       Example: node script.js 1990
*/

import fs from "fs";
import path from "path";
import { UltraPlonkBackend } from "@aztec/bb.js";
import { Noir } from "@noir-lang/noir_js";
import { zkVerifySession, ZkVerifyEvents } from "zkverifyjs";
import { Buffer } from "buffer";

// Load compiled circuit JSON via fs to avoid import assertions
const circuitPath = path.resolve(process.cwd(), "target/circuit.json");
if (!fs.existsSync(circuitPath)) {
  console.error("Error: circuit.json not found at target/circuit.json");
  process.exit(1);
}
const circuitJson = JSON.parse(fs.readFileSync(circuitPath, "utf8"));

// Read secret input from command line
const birthYear = parseInt(process.argv[2], 10);
if (isNaN(birthYear)) {
  console.error("Error: please pass a numeric birth_year as first argument.");
  process.exit(1);
}

async function generateWitness(noir, birth_year) {
  console.log("Generating witness... ⏳");
  const { witness } = await noir.execute({ birth_year, current_year: 2025 });
  console.log("Witness generated. ✅");
  return witness;
}

async function generateProof(backend, witness) {
  console.log("Generating proof... ⏳");
  const proofObj = await backend.generateProof(witness);
  console.log("Proof generated. ✅");
  return proofObj;
}

async function verifyLocally(backend, proofBytes, publicInputs) {
  console.log("Verifying proof locally... ⌛");
  // proofBytes is a Uint8Array
  const ok = await backend.verifyProof({ proof: proofBytes, publicInputs });
  console.log(`Local verification: proof is ${ok ? "valid ✅" : "invalid ❌"}`);
  if (!ok) process.exit(2);
}

async function registerVkOnZkVerify(session, vkHex) {
  console.log("Registering verification key on zkVerify... ⏳");
  const { events } = await session
    .registerVerificationKey()
    .ultraplonk()
    .execute(vkHex);
  const vkHash = await new Promise((resolve) => {
    events.on(ZkVerifyEvents.Finalized, (e) => {
      console.log(`VK registered: ${e.statementHash}`);
      resolve(e.statementHash);
    });
  });
  return vkHash;
}

async function verifyOnZkVerify(session, proofHex, vkHash, publicSignals) {
  console.log("Submitting proof to zkVerify... ⏳");
  const { events } = await session
    .verify()
    .ultraplonk()
    .withRegisteredVk(vkHash)
    .execute({
      proofData: { proof: proofHex, vk: vkHash, publicSignals },
      domainId: 0,
    });
  await new Promise((resolve) => {
    events.on(ZkVerifyEvents.Finalized, (data) => {
      console.log("Proof finalized on zkVerify. ✅", data);
      resolve(data);
    });
  });
}

(async () => {
  // Initialize Noir and backend
  const noir = new Noir(circuitJson);
  const backend = new UltraPlonkBackend(circuitJson.bytecode);

  // Generate witness & proof
  const witness = await generateWitness(noir, birthYear);
  const { proof: proofBytes, publicInputs } = await generateProof(
    backend,
    witness
  );

  // Convert proof bytes to hex string for on-chain submission
  const proofHex = "0x" + Buffer.from(proofBytes).toString("hex");

  // Local verification using raw bytes
  await verifyLocally(backend, proofBytes, publicInputs);

  // Start zkVerify session (Volta) with environment seed phrase
  const SEED = "process symptom pen humor shrimp enjoy sort setup castle abuse attitude tape" //process.env.ZKVERIFY_SEED || "seed phrase here";
  if (SEED == "seed phrase here") {
    console.error(
      "Error: Please set the ZKVERIFY_SEED environment variable with your seed phrase."
    );
    process.exit(1);
  }
  const session = await zkVerifySession.start().Volta().withAccount(SEED);

  // Register VK and get its hash
  // Load VK hex from file (e.g. generated via bb write_vk + noir-cli key)
  const vkPath = path.resolve(process.cwd(), "out/vk");
  if (!fs.existsSync(vkPath)) {
    console.error(
      "Error: vk.hex not found at target/vk.hex. Please generate and convert your VK to hex format."
    );
    process.exit(1);
  }
  const vkHex = fs.readFileSync(vkPath, "utf8").trim().split("")[0];
  console.log("VK loaded from file:", vkHex);
  const vkHash = await registerVkOnZkVerify(session, vkHex);

  // On-chain verification: publicInputs may include extra trailing value, slice if needed
  await verifyOnZkVerify(session, proofHex, vkHash, publicInputs.slice(0, -1));
})();
