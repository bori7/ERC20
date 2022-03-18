
const FlatERC721 = artifacts.require("FlatERC721");
module.exports = function(deployer, network, accounts) {
  deployer.deploy(FlatERC721,{from:accounts[0]});
};