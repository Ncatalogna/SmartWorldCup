var CoinFIFAWorldCup = artifacts.require("../contracts/CoinFIFAWorldCup.sol");
var SmartWorldCup = artifacts.require("../contracts/SmartWorldCup.sol");

module.exports = function(deployer) {
  deployer.deploy(CoinFIFAWorldCup);
  deployer.deploy(SmartWorldCup);
};
