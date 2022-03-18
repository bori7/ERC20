// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BoriToks is ERC20, Ownable {

    uint256 public  rate = 1000;
    uint public  gasprice = gasleft(); //tx.gasprice gives error
    uint public  gaslimit = block.gaslimit;

    constructor() ERC20("BoriToks", "BTK") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    event Buy(uint256 amount);

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function buyToken(address receiver) external payable{
        uint256 amountTobuy = gasprice * gaslimit * rate; // using the gas fee

        // require(msg.value >= 0, "You need to send some ether"); // when we have real eth sent.. 
        // uint256 amountTobuy = msg.value * rate * 10**decimals(); // for testnet, no eth sent i.e. 0 ETH
        
        mint(receiver, amountTobuy);
        emit Buy(amountTobuy);
    }
}
