import { Address, getContract, WalletClient } from "viem";
import { contract } from "../libs/contracts.abi";
import { provider } from "../libs/provider";
import { useEffect, useState } from "react";

export function useContract(wallet?: WalletClient, account?: Address) {
  const [contractClient, setContractClient] = useState<any>();
  const [decimals, setDecimals] = useState<number>(0);
  const [symbol, setSymbol] = useState<string>("-");
  const [name, setName] = useState<string>("-");

  useEffect(() => {
    if (!wallet || !account || account === "0x0") return;

    const readContract = async () => {
      const _contractClient = getContract({
        address: contract.address as Address,
        abi: contract.abi,
        client: {
          public: provider,
          wallet,
          account,
        },
      });

      setContractClient(_contractClient);

      try {
        const _name = await _contractClient.read.name();
        setName(_name as string);

        const _symbol = await _contractClient.read.symbol();
        setSymbol(_symbol as string);

        const _decimals = await _contractClient.read.decimals();
        setDecimals(_decimals as number);
      } catch (err) {
        console.error("Erro ao ler o contrato:", err);
      }
    };

    readContract();
  }, [wallet, account]);

  return { name, symbol, decimals, contractClient };
}
