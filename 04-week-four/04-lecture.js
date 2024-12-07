/**
 *  ---------------------------------------------
 *  |             Week Four Lecture             |
 *  ---------------------------------------------
 *  |                                           |
 *  |         -> Add Account To Wallet          |
 *  |         -> Sign Tx With Wallet            |
 *  |         -> Send Sign Transaction          |
 *  |                                           |
 *  ---------------------------------------------
 */

/**
 * 1. Setup:
 *      - Enable ganache private blockchain
 *      - Enter node environment
 *      - Import Web3 & web3
 *
 * 2. Generate New Account:
 *      - Run the below coding (Change data if needed)
 *
 * 3. Save New Account To Account Wallet
 *
 * 4. Load The Account Wallet For Signing Tx Purposes
 *
 * 5. Send Sign Transaction
 *
 */

// Import Web3 & web3
const Web3 = require("web3")
const web3 = new Web3.Web3("http://127.0.0.1:7545")

// Generate New Account
const newAcc = web3.eth.accounts.create()

// Add New Account To Wallet
web3.eth.accounts.wallet.add(newAcc)

// Log Out Wallet List
console.log(web3.eth.accounts.wallet[0])

// Send Funds To New Account
web3.eth.sendTransaction({
  from: "0xBa6aB02C8a7cF2885B2E72fd83F91c3F9541Bd80", // Sender public address
  to: newAcc.address, // Receiver public address
  value: web3.utils.toWei("2.5", "ether"),
})

// Check New Account Balance - Return ETH Unit
await web3.eth.getBalance(newAcc.address).then((balance) => {
  const balanceInETH = web3.utils.fromWei(balance, "ether")
  console.log(`Balance: ${balanceInETH} ETH`)
})

// Get Your First Account In The Wallet
const walletAccount = web3.eth.accounts.wallet[0]

// Create Transaction For New Account
const tx = {
  to: "0xB21d27219D42DfDE98547977fC01b236316f8D9C", // Receiver address
  value: web3.utils.toWei("0.8", "ether"), // Tx value
  gas: 21000,
  gasPrice: web3.utils.toWei("13", "gwei"),
  nonce: await web3.eth.getTransactionCount(walletAccount.address, "pending"),
}

// Sign Transaction With New Account
const signedTx = await walletAccount.signTransaction(tx)

// Send The Signed Transaction To The Network
const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction)

// Check Back New Account Balance
await web3.eth.getBalance(walletAccount.address)
