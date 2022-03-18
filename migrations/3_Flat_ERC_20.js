const FlatERC20 = artifacts.require("FlatERC20");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(FlatERC20, {from:accounts[0]});
};
