import { createPublicClient, http } from "viem";
import { sepolia } from "viem/chains";

export const provider = createPublicClient({
  chain: sepolia,
  transport: http(),
});
