const fs = require("fs/promises");
const { exec } = require("child_process");
const path = require("path");
const util = require("util");
const execPromise = util.promisify(exec);

const express = require("express");
const cors = require("cors");
const app = express();
const port = 3030;

// Middleware
app.use(cors());
app.use(express.json());

// Root route
app.get("/", (req, res) => {
  res.send("Hello World!");
});

// POST endpoint to receive proof and verification key
app.post("/verify", async (req, res) => {
  try {
    const { proof, vk, public_inputs } = req.body;

    // Here you can add additional verification logic if needed
    console.log("Received proof:");
    console.log("Received verification key:");

    await sendToZKV(proof, vk);

    res.json({
      success: true,
      message: "Proof and verification key received successfully",
    });
  } catch (error) {
    console.error("Error processing proof:", error);
    res.status(500).json({ success: false, message: "Error processing proof" });
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

async function sendToZKV(proof, vk) {
  console.log(
    "show in backend",
    JSON.stringify({
      proof,
      vk,
    })
  );

  console.log("Starting sendToZKV process...");
  const tempDir = "./tmp_zk";
  await fs.mkdir(tempDir, { recursive: true });

  const proofPath = path.join(tempDir, "proof.bin");
  const vkPath = path.join(tempDir, "vk.bin");
  const proofHexPath = path.join(tempDir, "proof.hex");
  const pubHexPath = path.join(tempDir, "pub.hex");
  const vkHexPath = path.join(tempDir, "vk.hex");

  const proofUint8 = Uint8Array.from(Object.values(proof));
  const vkUint8 = Uint8Array.from(Object.values(vk));

  console.log("proofUint8: ", proofUint8);
  console.log("vkUint8: ", vkUint8);

  console.log("Writing binary files...");
  await fs.writeFile(proofPath, proofUint8);
  await fs.writeFile(vkPath, vkUint8);
  console.log("Binary files written successfully");

  try {
    console.log("Running noir-cli proof-data command...");
 sole.log("Proof data generated successfully");

    console.log("Running noir-cli key command...");
    await execPromise(`noir-cli key --input ${vkPath} --output ${vkHexPath}`);
    console.log("Key data generated successfully");
  } catch (err) {
    console.error("Erro ao executar noir-cli:", err.stderr || err);
    throw err;
  }

  console.log("Reading output files...");
  const [proofHex, pubHex, vkHex] = await Promise.all([
    fs.readFile(proofHexPath, "utf8"),
    fs.readFile(pubHexPath, "utf8"),
    fs.readFile(vkHexPath, "utf8"),
  ]);

  const result = {
    proofHex: proofHex.trim(),
    pubHex: pubHex.trim(),
    vkHex: vkHex.trim(),
  };

  console.log("sendToZKV process completed successfully");

  return result;
}
