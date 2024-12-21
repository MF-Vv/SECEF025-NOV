# Week Seven - Common Interaction with Web3.js

## 1. Environment Setup:

Ensure Ganache is running on your local machine with an available Ethereum network.  
Import `web3.js-browser` library to your project:

```html
<script src="../node_modules/web3.js-browser/build/web3.js"></script>
```

## 2. Key Concepts Covered:

### a) Fetching Accounts:

Retrieve ethereum accounts:

```javascript
const accounts = await web3.eth.getAccounts()
```

Create and append HTML elements to display accounts:

```javascript
// Create a Container Element (an unordered list, <ul>) to hold the accounts:
let unOrderList = document.createElement("ul")

// Create and Append List Items (<li>) for Each Account:
accounts.forEach((acc) => {
  let listItem = document.createElement("li")
  listItem.innerText = acc
  unOrderList.append(listItem)
})

// Append the Unordered List to a Container (outputDiv):
outputDiv.append(unOrderList)
```

### b) Fetching Balances:

Prompt user for an address and fetch balance:

```javascript
const addressInput = prompt("Enter your address: ")
const balance = await web3.eth.getBalance(addressInput)
const balanceInETH = web3.utils.fromWei(balance, "ether")
outputDiv.innerText = `Address: ${addressInput} has ${balanceInETH} ETH.`
```

### c) Sending Transactions:

Basic transaction example:

```javascript
const tx = {
  from: accounts[0],
  to: accounts[1],
  value: web3.utils.toWei("1", "ether"),
}

// ATTENTION:
// No output is returned when using web3.js-browser unless with web3.js.
web3.eth.sendTransaction(tx)

// Attach tx events to get output (refer below...)
```

Listening to transaction events using `.on` including `transactionHash`, `confirmation`, `receipt`, and `error`:

```javascript
web3.eth
  .sendTransaction(tx)
  .on("transactionHash", (txHash) => {
    console.log(`Transaction Hash: ${txHash}`)

    // Get receipt by tx hash (Optional)
    const receipt = await web3.eth.getTransactionReceipt(txHash)
    console.log("Receipt: ", receipt)
  })
  .on("confirmation", (confirmationNumber, receipt) => {
    console.log(`Confirmation Number: ${confirmationNumber}`)
  })
  .on("receipt", (receipt) => {
    console.log("Receipt: ", receipt)
  })
  .on("error", (error) => {
    console.error(`Error: ${error.message}`)
  })
```

### d) Creating New Ethereum Accounts:

Create a new Ethereum account:

```javascript
const newAccount = web3.eth.accounts.create()
console.log(`New Account Address: ${newAccount.address}`)
console.log(`New Account Private Key: ${newAccount.privateKey}`)
```

### e) Send Signed Transactions:

Prepare tx and sign a transaction:

```javascript
const tx = {
  from: sender,
  to: receiver,
  value: amountInWei,
  nonce: nonce,
  gas: 30000,
  gasPrice: await web3.eth.getGasPrice(),
}
const signedTx = await web3.eth.accounts.signTransaction(tx, privateKey)
```

Send the signed transaction and handle events:

```javascript
web3.eth
  .sendSignedTransaction(signedTx.rawTransaction)
  .on("transactionHash", (txHash) => {
    console.log(`Transaction Hash: ${txHash}`)
  })
  .on("confirmation", (confirmationNumber, receipt) => {
    console.log(`Confirmation Number: ${confirmationNumber}`)
    console.log("Receipt: ", receipt)
  })
  .on("error", (error) => {
    console.error(`Error: ${error.message}`)
  })
```

## 3. Steps to Run:

- Ensure Ganache is running on your local Ethereum network.
- Use `Live Server Extension` to run your HTML file.
- Test the functionality by creating new accounts, fetching balances, and sending transactions.

## 4. Expected Outcomes:

- Successfully retrieve Ethereum accounts and balances.
- Create new Ethereum accounts.
- Send both basic and signed transactions, with event handling for transaction status, hash, and confirmation.
