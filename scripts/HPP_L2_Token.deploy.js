const { ethers } = require("hardhat");

async function main() {
  console.log("Deploying HousePartyProtocol Token contract...");

# L2 address
const HPP_TOKEN_Recipient = "0x89670dd1188F612648207351afC2490D3634E631"; // HPP Token Recipient

  const [deployer] = await ethers.getSigners();
  console.log("Deploying with account:", deployer.address);

  const HPPToken = await ethers.getContractFactory("L2HousePartyProtocol");
  const token = await HPPToken.deploy(
    HPP_TOKEN_Recipient,
    deployer.address // initialOwner
  );

  await token.waitForDeployment();
  console.log("HousePartyProtocol deployed to:", await token.getAddress());
  console.log("HousePartyProtocol token recipient to:", HPP_TOKEN_Recipient);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
