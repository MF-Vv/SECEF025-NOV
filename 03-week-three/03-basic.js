/**
 *  ---------------------------------------------
 *  |           Week Three Lecture              |
 *  |--------------------------------------------
 *  |                                           |
 *  |    -> Fundamental Logic & Implementation  |
 *  |                                           |
 *  ---------------------------------------------
 */

/**
 * 1. Setup:
 *      - Enable ganache private blockchain
 *      - Enter node environment
 *      - Import Web3 & web3
 *
 * 2. Familiar With Basic Implementation FIRST!!!!!!!!!!!!!!!!!!
 *
 */

// Import Web3 & web3
const Web3 = require("web3")
const web3 = new Web3.Web3("http://127.0.0.1:7545")

// Get Ganache Account List
await web3.eth.getAccounts(console.log)
web3.eth.getAccounts().then((accList) => console.log(accList))

// Get Balance
await web3.eth.getBalance("0xb21CD69c11E945Bcd0FFB842696375B5B929A6C5")
web3.eth
  .getBalance("0xb21CD69c11E945Bcd0FFB842696375B5B929A6C5")
  .then((balance) => console.log(balance))

// ETH -> WEI UNIT
web3.utils.toWei("1", "ether")
web3.utils.toWei("10", "gwei")
web3.utils.toWei("1", "mwei")

// WEI > ETH UNIT
web3.utils.fromWei("100000000000000000000", "ether")

// Advance Implementation (Apply web3.utils into getBalance return function)
web3.eth
  .getBalance("0xb21CD69c11E945Bcd0FFB842696375B5B929A6C5")
  .then((balance) =>
    console.log(`User has ${web3.utils.fromWei(balance, "ether")} ETH.`)
  )
