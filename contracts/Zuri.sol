// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Zuri is ERC20{

    constructor(uint256 _supply) public ERC20 ("BORICOIN", "BOR") {
      _mint(msg.sender, _supply * (10 ** decimals()));
    }
}
