async function main() {
  const MonkeyGameToken= await ethers.getContractFactory("MonkeyGameToken");

  // Start deployment, returning a promise that resolves to a contract object
  const monkeyGameToken = await MonkeyGameToken.deploy(1);
  console.log("Contract deployed to address:", monkeyGameToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });