## Send ETH to User with MetaMask (Low-level Interaction)

This code snippet demonstrates how to send an Ethereum transaction using MetaMask's JSON-RPC API and web3.js.

### Step-by-Step Breakdown

1. **Request User Accounts:**

   ```javascript
   const accounts = await window.ethereum.request({
     method: "eth_requestAccounts",
     params: [{ eth_accounts: {} }],
   })
   ```

   - This request prompts the user to authorize access to their Ethereum accounts. The authorized accounts are returned as a promise.

2. **Select the From Address:**

   ```javascript
   const fromAddress = ethereum.selectedAddress
   ```

   - The `fromAddress` is set to the currently selected address in MetaMask.

3. **Define Transaction Parameters:**

   ```javascript
   const transactionParameters = {
     to: toAddress,
     from: fromAddress,
     value: web3.utils.toHex(web3.utils.toWei(amountInEther, "ether")), // Convert ETH to Wei using Web3
   }
   ```

   - `to`: The recipient's Ethereum address.
   - `from`: The sender's Ethereum address.
   - `value`: The amount to send, converted from Ether to Wei.

4. **Send Transaction using MetaMask:**

   ```javascript
   const txHash = await window.ethereum.request({
     method: "eth_sendTransaction",
     params: [transactionParameters],
   })
   console.log("Transaction sent! Hash:", txHash)
   alert("Transaction sent! Hash: " + txHash)
   ```

   - Sends the transaction via MetaMask and logs the transaction hash upon success.

5. **Alternative: Send Transaction using web3.js:**

   ```javascript
   web3.eth
     .sendTransaction(transactionParameters)
     .on("transactionHash", (txHash) => {
       console.log("Transaction sent! Hash:", txHash)
     })
     .on("receipt", (receipt) => {
       console.log("Transaction confirmed! Receipt:", receipt)
     })
     .on("confirmation", (confirmationNumber, receipt) => {
       console.log(
         `Transaction confirmed ${confirmationNumber} times.`,
         receipt
       )
     })
     .on("error", (error) => {
       console.error("Transaction failed:", error.message)
     })
   ```

   - This code shows how to use web3.js to send the transaction, providing additional events such as `receipt`, `confirmation`, and `error` for more detailed transaction handling.

### Note:

- Ensure MetaMask is installed and the user is connected to the desired Ethereum network.
- Handle exceptions and errors gracefully in a production environment.

## Send Fund To Contract with MetaMask (Low-level Interaction)

This code snippet demonstrates low-level interaction to send a transaction on the Ethereum blockchain.

It includes steps to connect to MetaMask, convert the amount to Wei, create a transaction object, estimate gas, and send the transaction.

**Note**: The contract is set up to accept funds with the `receive()` special function.

```javascript
// 1. Get the account address
const account = await connectMetaMask()

// 2. Convert the amount to wei
const weiAmount = web3.utils.toWei(amount, "ether")

// 3. Create the transaction object
const tx = {
  from: account,
  to: CONTRACT_ADDR,
  value: web3.utils.numberToHex(weiAmount),
}

// 4. Estimate the gas cost
const gasEstimate = await window.ethereum.request({
  method: "eth_estimateGas",
  params: [tx],
})

// 5. Add the gas price and gas fee to the transaction object
tx.gas = gasEstimate
tx.gasPrice = web3.utils.numberToHex(await web3.eth.getGasPrice())

// 6. Send the transaction
await window.ethereum.request({
  method: "eth_sendTransaction",
  params: [tx],
})
```
