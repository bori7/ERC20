const BlockBori = artifacts.require("BlockBori");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(BlockBori, {from:accounts[0]});
};
