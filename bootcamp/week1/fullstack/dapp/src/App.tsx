import { useContract } from "./hooks/useContract";
import { useWallet } from "./hooks/useWallet";
import { WalletClient } from "viem";
import React from "react";
import { Dashboard } from "./components/Dashboard";
import ParticlesBackground from "./components/particles/ParticlesBackground";
import "./styles/global.css";

function App() {
  const { account, client, error, connectWallet } = useWallet();
  const { name, symbol, decimals, contractClient } = useContract(client as WalletClient, account);

  return (
    <>
      <ParticlesBackground />
      <div className="container">
        <h1 className="title">O Grande Código</h1>
        {account !== "0x0" && contractClient ? (
          <div className="card">
            <Dashboard
              account={account}
              contract={contractClient}
              name={name}
              symbol={symbol}
              decimals={decimals}
            />
          </div>
        ) : (
          <div id="disconnected">
            <button className="connect-btn" onClick={connectWallet}>
              <i className="fas fa-wallet"></i> Conectar MetaMask
            </button>
            {error && <p style={{ color: "red" }}>{error}</p>}
          </div>
        )}
      </div>
    </>
  );
}

export default App;
