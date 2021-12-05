const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);

  let waveCount;
  waveCount = await waveContract.getTotalWaves();

  let waveTxn = await waveContract.wave();
  await waveTxn.wait()

  // Should've been updated
  waveCount = await waveContract.getTotalWaves();

  // Now random person waves
  waveTxn = await waveContract.connect(randomPerson).wave();
  await waveTxn.wait();

  waveCount = await waveContract.getTotalWaves();

  // Let's poke someone as it's done in Facebook years before
  let pokeCount;
  pokeCount = await waveContract.getTotalPokes();

  pokeTxn = await waveContract.poke();
  await pokeTxn.wait();

  pokeCount = await waveContract.getTotalPokes();
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
