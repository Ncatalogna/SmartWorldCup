var Owner = artifacts.require("../contracts/Owner.sol");

module.exports = function(deployer) {
  deployer.deploy(Owner);
};
