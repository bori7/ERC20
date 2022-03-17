// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IERC20ZURI {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract BlockBori is IERC20ZURI {

    string public constant name = "BoriToken";
    string public constant symbol = "BT";
    uint8 public constant decimals = 18;
    uint256 public totalSupply_;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;


    constructor() {
        totalSupply_ = 10**6 * (10 ** decimals);
        balances[msg.sender] = totalSupply_;
    }

    event Received(address, uint);
    event Buy(uint256 amount);
    event Sell(uint256 amount);




    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender], "Insufficient Funds");
        balances[msg.sender] = balances[msg.sender] - numTokens;
        balances[receiver] = balances[receiver] + numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens) public override returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public override view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[owner],"Insufficient Tokens Available");
        require(numTokens <= allowed[owner][msg.sender], "Insufficient allowance");

        balances[owner] = balances[owner] - numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - numTokens;
        balances[buyer] = balances[buyer] + numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }

    

    function buyToken() public payable {
        uint256 amountTobuy = 1000 * 10**decimals ;
        uint256 dexBalance = balanceOf(tx.origin);
        require(amountTobuy > 0, "You need to send some ether");
        require(amountTobuy <= dexBalance, "Not enough tokens in the reserve");
        transfer(msg.sender, amountTobuy);
        emit Buy(amountTobuy);
    }

    function sell(uint256 amount) public {
        require(amount > 0, "You need to sell at least some tokens");
        uint256 allow = allowance(msg.sender, tx.origin);
        require(allow >= amount, "Check the token allowance");
        transferFrom(msg.sender, tx.origin, amount);
        payable(msg.sender).transfer(amount);
        emit Sell(amount);
    }

    receive() external payable{
        buyToken();
    }
}
