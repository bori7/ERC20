
const BoriERC721 = artifacts.require("BoriERC721");
module.exports = function(deployer, network, accounts) {
  deployer.deploy(BoriERC721,{from:accounts[0]});
};