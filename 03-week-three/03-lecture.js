/**
 *  ---------------------------------------------
 *  |           Week Three Lecture              |
 *  |--------------------------------------------
 *  |                                           |
 *  |    -> Sign Transaction With Private Key   |
 *  |    -> Send Sign Transaction               |
 *  |                                           |
 *  ---------------------------------------------
 */

/**
 * 1. Setup:
 *      - Enable ganache private blockchain
 *      - Enter node environment
 *      - Import Web3 & web3
 *
 * 2. Sign Transaction With Private Key:
 *      - Run the below coding (Change address if needed)
 *
 * 3. Send Sign Transaction
 *      - Run the below coding (Change address if needed)
 *
 */

// Import Web3 & web3
const Web3 = require("web3")
const web3 = new Web3.Web3("http://127.0.0.1:7545")

// Get Private Key From Ganache
const privateKey = "YOUR GANACHE ADDRESS'S PRIVATE KEY"

// Create Transaction
const tx = {
  from: "SENDER PUBLIC ADDRESS",
  to: "RECEIVER PUBLIC ADDRESS", // Receiver address
  value: web3.utils.toWei("10", "ether"), // Tx value
  gas: 21000,
  gasPrice: web3.utils.toWei("13", "gwei"),
  nonce: await web3.eth.getTransactionCount("SENDER PUBLIC ADDRESS", "pending"),
}

// Sign Transaction With New Account
const signedTx = await web3.eth.accounts.signTransaction(tx, privateKey)

// Send The Signed Transaction To The Network
const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction)

// Once completed, check the RECEIVER'S PUBLIC ADDRESS to see if the balance has increased.
