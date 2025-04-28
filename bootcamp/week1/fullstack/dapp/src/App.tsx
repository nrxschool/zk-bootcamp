import { ConnectWalletButton } from "./components/ConnectWalletButton";
import { Dashboard } from "./components/Dashboard";
import { useContract } from "./hooks/useContract";
import { useWallet } from "./hooks/useWallet";
import { WalletClient } from "viem";
import React from "react";

function App() {
  const { account, client, connectWallet } = useWallet();
  const { name, symbol, decimals, contractClient } = useContract(client as WalletClient, account);

  return (
    <div style={{ padding: "20px", textAlign: "center" }}>
      <h1>Web3 Token dApp</h1>
      {account !== "0x0" && contractClient ? (
        <Dashboard
          account={account}
          contract={contractClient}
          name={name}
          symbol={symbol}
          decimals={decimals}
        />
      ) : (
        <ConnectWalletButton connectWallet={connectWallet} />
      )}
    </div>
  );
}

export default App;
