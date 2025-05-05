import { Abi, Address, isAddress } from "viem";
import React, { useEffect, useState } from "react";
import { provider } from "../libs/provider";

export interface DashboardProps {
  account: Address;
  decimals: number;
  contract: any;
  symbol: string;
  name: string;
}

export function Dashboard({
  account,
  name,
  symbol,
  decimals,
  contract,
}: DashboardProps) {
  const [balance, setBalance] = useState<bigint>(0n);
  const [isMinting, setIsMinting] = useState(false);
  const [isTransferring, setIsTransferring] = useState(false);
  const [transferTo, setTransferTo] = useState<string>("");
  const [transferAmount, setTransferAmount] = useState<string>("");
  const [error, setError] = useState<string | null>(null);
  const formattedBalance = balance / BigInt(10) ** BigInt(decimals);

  // Formata a mensagem de erro para exibição
  const formatErrorMessage = (error: string) => {
    // Remove partes técnicas comuns de erros da blockchain
    let formattedError = error;
    
    // Remove prefixos longos de erro
    if (formattedError.includes(': ')) {
      formattedError = formattedError.split(': ').slice(-1)[0];
    }
    
    // Limita o comprimento da mensagem
    if (formattedError.length > 300) {
      formattedError = formattedError.substring(0, 300) + '...';
    }
    
    return formattedError;
  };

  const readBalance = async () => {
    try {
      const _balance = await contract.read.balanceOf([account]);
      setBalance(_balance);
    } catch (error) {
      console.error("Erro ao ler o balance:", error);
    }
  };

  useEffect(() => {
    readBalance();
  }, [account, contract]);

  const mintTokens = async () => {
    console.log("Minting tokens...");
    setIsMinting(true);
    setError(null);
    try {
      const tx = await contract.write.mint([], { account });
      console.log("Transaction sent:", tx);

      // Aguarda a confirmação da transação
      const receipt = await provider.waitForTransactionReceipt({ hash: tx });
      console.log("Transaction confirmed:", receipt);

      // Atualiza o saldo após a confirmação
      await readBalance();
    } catch (error) {
      console.error("Error minting tokens:", error);
      setError("Erro ao mintar tokens: " + error.message);
    } finally {
      setIsMinting(false);
    }
  };

  const transferTokens = async () => {
    console.log("Transferring tokens...");
    setIsTransferring(true);
    setError(null);
    try {
      // Valida o endereço de destino
      if (!isAddress(transferTo)) {
        throw new Error("Endereço de destino inválido");
      }

      // Valida o valor
      const amount = Number(transferAmount);
      if (isNaN(amount) || amount <= 0) {
        throw new Error("O valor deve ser maior que 0");
      }

      // Converte o valor para a unidade correta (considerando decimals)
      const amountInWei = BigInt(Math.floor(amount * 10 ** decimals));
      if (amountInWei > balance) {
        throw new Error("Saldo insuficiente para a transferência");
      }

      // Executa a transferência
      const tx = await contract.write.transfer([transferTo as Address, amountInWei], { account });
      console.log("Transfer transaction sent:", tx);

      // Aguarda a confirmação da transação
      const receipt = await provider.waitForTransactionReceipt({ hash: tx });
      console.log("Transfer transaction confirmed:", receipt);

      // Atualiza o saldo após a confirmação
      await readBalance();

      // Limpa os campos
      setTransferTo("");
      setTransferAmount("");
    } catch (error) {
      console.error("Error transferring tokens:", error);
      setError("Erro ao transferir tokens: " + error.message);
    } finally {
      setIsTransferring(false);
    }
  };

  const dismissError = () => {
    setError(null);
  };

  // Impede o scroll quando o erro está aberto
  useEffect(() => {
    if (error) {
      document.body.style.overflow = 'hidden';
    } else {
      document.body.style.overflow = 'auto';
    }
    
    return () => {
      document.body.style.overflow = 'auto';
    };
  }, [error]);

  return (
    <div>
      <div className="info">
        <i className="fas fa-wallet"></i>
        <span>Carteira conectada: {account.substring(0, 6)}...{account.substring(account.length - 4)}</span>
      </div>
      <div className="info">
        <i className="fas fa-coins"></i>
        <span>Token: {name}</span>
      </div>
      <div className="info">
        <i className="fas fa-balance-scale"></i>
        <span>Saldo: <span id="balance">{formattedBalance.toString()}</span> {symbol}</span>
      </div>

      <button className="claim-btn" onClick={mintTokens} disabled={isMinting}>
        {isMinting ? "Minting..." : "Claim your Tokens!"}
      </button>

      {balance > 0n && (
        <div className="transfer-section">
          <h2 className="transfer-title">Transferir Tokens</h2>
          <div className="transfer-form">
            <input
              type="text"
              className="transfer-input"
              placeholder="Endereço de destino (0x...)"
              value={transferTo}
              onChange={(e) => setTransferTo(e.target.value)}
              disabled={isTransferring}
              style={{ width: "300px" }}
            />
            <input
              type="number"
              className="transfer-input"
              placeholder="Quantidade"
              value={transferAmount}
              onChange={(e) => setTransferAmount(e.target.value)}
              disabled={isTransferring}
              min="0"
              step="0.0001"
              style={{ width: "150px" }}
            />
            <button 
              className="transfer-btn" 
              onClick={transferTokens} 
              disabled={isTransferring}
            >
              {isTransferring ? "Transferindo..." : "Transferir"}
            </button>
          </div>
        </div>
      )}

      {error && (
        <div className="error-popup-overlay" onClick={dismissError}>
          <div className="error-popup" onClick={(e) => e.stopPropagation()}>
            <button className="error-popup-close" onClick={dismissError}>
              <i className="fas fa-times"></i>
            </button>
            
            <div className="error-popup-title">
              <i className="fas fa-exclamation-triangle"></i>
              <h3>Erro na Operação</h3>
            </div>
            
            <div className="error-popup-content">
              {formatErrorMessage(error)}
            </div>
            
            <button className="error-popup-button" onClick={dismissError}>
              Entendi
            </button>
          </div>
        </div>
      )}
    </div>
  );
}