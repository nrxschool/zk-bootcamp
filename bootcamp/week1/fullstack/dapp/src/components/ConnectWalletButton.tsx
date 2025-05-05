import { Address } from "viem";
import React from "react";

interface ConnectWalletButtonProps {
  account: Address | null;
  error: string | null;
  connectWallet: () => Promise<void>;
}

export function ConnectWalletButton({
  account,
  error,
  connectWallet,
}: ConnectWalletButtonProps) {

  console.log("foi")
  return (


    <div className="particles" id="particles">
      <div className="container">
        <h1 className="title">Web3 Token dApp</h1>
        <div id="disconnected">
          <button className="connect-btn" onClick={connectWallet}>
            <i className="fas fa-wallet"></i> Conectar MetaMask
          </button>
          {error && <p style={{ color: "red" }}>{error}</p>}
        </div>
      </div>
    </div>
  )
}



