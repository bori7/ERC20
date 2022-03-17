const Zuri = artifacts.require("Zuri");

contract ("Zuri", (accounts) => {

    console.log(accounts);

    before(async ()=>{
        zuri = await Zuri.deployed();
    })

    it("gives bori 1 million tokens", async () => {
        let balance = await zuri.balanceOf(accounts[0]);
        balance = web3.utils.fromWei(balance, "ether");
        assert.equal(balance, "1000000", "Balance should be 1M Bori coins for Bori DAO creations");
    })

    it("it transfers bori coins between accounts", async() => {
        let amount = web3.utils.toWei('1000', 'ether');
        await zuri.transfer(accounts[1], amount, { from: accounts[0] })

        let balance = await zuri.balanceOf(accounts[1]);
        balance = web3.utils.fromWei(balance, "ether");
        assert.equal(balance, "1000", "Balance should be 1k Bori Coins for Bori DAO creations");
    
    })
})