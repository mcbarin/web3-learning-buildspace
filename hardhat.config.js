require('@nomiclabs/hardhat-waffle');

module.exports = {
  solidity: '0.8.0',
  networks: {
    rinkeby: {
      url: '[ALCHEMY_URL]',
      accounts: '[ACCOUNT_ADDRESS]',
    },
  },
};
