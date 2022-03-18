const BoriERC20 = artifacts.require("BoriERC20");

module.exports = function (deployer) {
  deployer.deploy(BoriERC20);
};
