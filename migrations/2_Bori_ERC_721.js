const BoriERC721 = artifacts.require("BoriERC721");

module.exports = function (deployer) {
  deployer.deploy(BoriERC721, 1000000);
};
