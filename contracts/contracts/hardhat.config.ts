import { HardhatUserConfig, task } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";
import path from "path";

dotenv.config();

// ✅ Deploy Task (runs ./scripts/deploy.ts)
task("deploy", "Deploys the WhitelistToken contract").setAction(
  async (_, hre) => {
    const deploy = (await import(path.join(__dirname, "scripts", "deploy")))
      .default;
    await deploy(hre);
  }
);

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    validiumL2: {
      url: process.env.RPC_URL || "http://localhost:8123",
      chainId: 1001,
      accounts: [process.env.PRIVATE_KEY!],
    },
  },
};

export default config;
