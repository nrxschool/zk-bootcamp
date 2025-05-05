import { Address, createWalletClient, custom, WalletClient } from "viem";
import { sepolia } from "viem/chains";
import { useState, useEffect } from "react";

export function useWallet() {
  const [account, setAccount] = useState<Address>("0x0");
  const [client, setClient] = useState<WalletClient>();
  const [error, setError] = useState<string | null>(null);

  const connectWallet = async () => {
    try {
      if (!window.ethereum) {
        throw new Error("MetaMask não está instalado");
      }

      const walletClient = createWalletClient({
        chain: sepolia,
        transport: custom(window.ethereum),
      });

      const [address] = await walletClient.requestAddresses();
      setClient(walletClient);
      setAccount(address);
      setError(null);
    } catch (err) {
      setError("Falha ao conectar com MetaMask");
      console.error(err);
    }
  };

  useEffect(() => {
    const checkConnection = async () => {
      try {
        if (!window.ethereum) return;

        const walletClient = createWalletClient({
          chain: sepolia,
          transport: custom(window.ethereum),
        });

        const accounts = await window.ethereum.request({
          method: "eth_accounts",
        });
        if (accounts.length > 0) {
          setClient(walletClient);
          setAccount(accounts[0]);
          setError(null);
        }
      } catch (err) {
        console.error("Erro ao verificar conexão inicial:", err);
      }
    };

    checkConnection();
  }, []);

  return { account, client, error, connectWallet };
}
