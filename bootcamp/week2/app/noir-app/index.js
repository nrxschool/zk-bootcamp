import QRCode from 'qrcode';

const show = (id, content, type = 'info') => {
  const container = document.getElementById(id);
  const entry = document.createElement('div');
  entry.className = `log-entry ${type}`;
  entry.appendChild(document.createTextNode(content));
  container.appendChild(entry);
  container.scrollTop = container.scrollHeight;
};

const generateQRCode = async (data) => {
  try {
    const qrContainer = document.getElementById('qrcode');
    qrContainer.innerHTML = ''; // Clear previous QR code
    const qrDataUrl = await QRCode.toDataURL(JSON.stringify(data), {
      width: 200,
      margin: 2,
      color: {
        dark: '#4a90e2',
        light: '#ffffff'
      }
    });
    const img = document.createElement('img');
    img.src = qrDataUrl;
    qrContainer.appendChild(img);
  } catch (error) {
    console.error('Error generating QR code:', error);
    show('logs', 'Error generating QR code', 'error');
  }
};

document.getElementById("submit").addEventListener("click", async () => {
  try {
    const birthDate = new Date(document.getElementById("birth_year").value);
    if (isNaN(birthDate.getTime())) {
      show('logs', 'Please select a valid date', 'error');
      return;
    }

    const birth_year = birthDate.getFullYear();
    const current_year = new Date().getFullYear();

    const { UltraHonkBackend } = await import("@aztec/bb.js");
    const { Noir } = await import("@noir-lang/noir_js");
    const circuit = await import("./target/circuit.json");

    const noir = new Noir(circuit.default);
    const backend = new UltraHonkBackend(circuit.default.bytecode);

    show("logs", "Generating witness... ⏳");
    const { witness } = await noir.execute({ birth_year, current_year });
    show("logs", "Generated witness... ✅", 'success');

    show("logs", "Generating proof... ⏳");
    const proof = await backend.generateProof(witness);
    show("logs", "Generated proof... ✅", 'success');

    // Generate QR code for the proof
    await generateQRCode(proof);

    show("logs", "Verifying proof... ⌛");
    const isValid = await backend.verifyProof(proof);
    show("logs", `Proof is ${isValid ? "valid" : "invalid"}... ✅`, isValid ? 'success' : 'error');
  } catch (error) {
    show("logs", "Error: " + error.message, 'error');
    console.error(error);
  }
});
