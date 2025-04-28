import React from "react";

interface ConnectWalletButtonProps {
  connectWallet: () => Promise<void>;
}

export function ConnectWalletButton({ connectWallet }: ConnectWalletButtonProps) {
  return (
    <div>
      <button onClick={connectWallet}>Conectar MetaMask</button>
    </div>
  );
}