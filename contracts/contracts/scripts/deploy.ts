import { ethers } from "hardhat";
import { parseEther } from "ethers";

export default async function deploy(hre: any) {
  console.log("🚀 Starting contract deployment...");

  const Token = await ethers.getContractFactory("WhitelistToken");
  const initialSupply = parseEther("1000000");
  const token = await Token.deploy("DemoToken", "DMT", initialSupply);

  await token.waitForDeployment();
  const address = await token.getAddress();

  console.log("✅ Contract deployed at:", address);
}
