/** @type import('hardhat/config').HardhatUserConfig */
require("@nomiclabs/hardhat-waffle");

const Goerli_Private_KEY="c3f96be3214cdd12d90c21f344b2d6eb60fd9ca9845b5b876adafd0cfa1258ba";

module.exports = {
  defaultNetwork: "goerli",
networks: {
  hardhat: {
  },
  goerli: {
    url: "https://eth-goerli.g.alchemy.com/v2/LDTeJdWrz5gTNBhni_E7ZugAjkzOElGE",
    accounts: [`${Goerli_Private_KEY}`]
  }
},
  solidity: "0.8.19",

};
