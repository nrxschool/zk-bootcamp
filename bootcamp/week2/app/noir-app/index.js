import QRCode from 'qrcode';

const show = (id, content, type = 'info') => {
  const container = document.getElementById(id);
  const entry = document.createElement('div');
  entry.className = `log-entry ${type}`;
  entry.appendChild(document.createTextNode(content));
  container.appendChild(entry);
  container.scrollTop = container.scrollHeight;
};

const clearLogs = () => {
  const logsContainer = document.getElementById('logs');
  // Keep the header
  const header = logsContainer.querySelector('h2');
  logsContainer.innerHTML = '';
  logsContainer.appendChild(header);
};

const formatBytes = (bytes) => {
  if (bytes === 0) return '0 Bytes';
  const k = 1024;
  const sizes = ['Bytes', 'KB', 'MB', 'GB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
};

const generateQRCode = async (data) => {
  try {
    const qrContainer = document.getElementById('qrcode');
    qrContainer.innerHTML = ''; // Clear previous QR code
    
    // Convert data to string and compress it
    const dataString = JSON.stringify(data);
    show('logs', `QR Code data size: ${formatBytes(dataString.length)}`, 'info');
    
    const qrDataUrl = await QRCode.toDataURL(dataString, {
      version: 40, // Maximum version (40)
      errorCorrectionLevel: 'H', // Highest error correction level
      width: 400, // Increased size for better readability
      margin: 2,
      color: {
        dark: '#4a90e2',
        light: '#ffffff'
      }
    });
    
    const img = document.createElement('img');
    img.src = qrDataUrl;
    qrContainer.appendChild(img);
    
    // Add download button
    const downloadBtn = document.createElement('button');
    downloadBtn.textContent = 'Download QR Code';
    downloadBtn.className = 'download-button';
    downloadBtn.onclick = () => {
      const link = document.createElement('a');
      link.download = 'proof-qrcode.png';
      link.href = qrDataUrl;
      link.click();
    };
    qrContainer.appendChild(downloadBtn);
    
  } catch (error) {
    console.error('Error generating QR code:', error);
    show('logs', 'Error generating QR code: ' + error.message, 'error');
  }
};

// Add event listener for clear logs button
document.getElementById('clear-logs').addEventListener('click', clearLogs);

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
    const witnessStartTime = performance.now();
    const { witness } = await noir.execute({ birth_year, current_year });
    const witnessTime = ((performance.now() - witnessStartTime) / 1000).toFixed(2);
    show("logs", `Generated witness in ${witnessTime}s... ✅`, 'success');

    show("logs", "Generating proof... ⏳");
    const proofStartTime = performance.now();
    const proof = await backend.generateProof(witness);
    const proofTime = ((performance.now() - proofStartTime) / 1000).toFixed(2);
    const proofSize = new Blob([JSON.stringify(proof)]).size;
    show("logs", `Generated proof in ${proofTime}s (${formatBytes(proofSize)})... ✅`, 'success');

    // Generate QR code for the proof
    await generateQRCode(proof);

    show("logs", "Verifying proof... ⌛");
    const verifyStartTime = performance.now();
    const isValid = await backend.verifyProof(proof);
    const verifyTime = ((performance.now() - verifyStartTime) / 1000).toFixed(2);
    show("logs", `Proof is ${isValid ? "valid" : "invalid"} (verified in ${verifyTime}s)... ✅`, isValid ? 'success' : 'error');

    // Show total time
    const totalTime = ((performance.now() - witnessStartTime) / 1000).toFixed(2);
    show("logs", `Total processing time: ${totalTime}s`, 'info');
  } catch (error) {
    show("logs", "Error: " + error.message, 'error');
    console.error(error);
  }
});
