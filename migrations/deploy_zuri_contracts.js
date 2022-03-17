const Zuri = artifacts.require("Zuri");

module.exports = function (deployer) {
  deployer.deploy(Zuri, 1000000);
};
