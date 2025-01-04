## Steps to Interact with the Contract With Web3.js

Create a Web3 instance with Ganache's Ethereum provider.

```javascript
const web3 = new Web3("http://localhost:7545")
```

Set the `contractAddress` and `contractABI` (Application Binary Interface).

```javascript
const contractAddress = "CONTRACT ADDRESS"
const contractABI = "ABI"
```

Create the contract instance.

```javascript
const contract = new web3.eth.Contract(contractABI, contractAddress)
```

## Interacting with Getter Functions in Ethereum Smart Contracts Using Web3.js

This guide covers how to interact with an Ethereum smart contract using Web3.js. The contract in question is designed for storing and managing various data types and user balances.

### Example: Using `contract.methods`

```javascript
const creationDateTime = await contract.methods.creationDate().call()

let formattedDate = new Date(creationDateTime * 1000).toLocaleDateString(
  "en-GB"
)
```

### Example: Low-Level Call with Multiple Return Values

This example demonstrates how to use low-level calls with Web3.js to interact with the smart contract.

1. **Encode the Function Signature**

```javascript
const functionSignature = web3.eth.abi.encodeFunctionSignature(
  "getAllData(address)"
)
```

2. **Encode the Function Parameter**

```javascript
const encodedParameter = web3.eth.abi.encodeParameter("address", userAddress)
```

3. **Combine the Function Signature and Encoded Parameter**

```javascript
const data = functionSignature + encodedParameter.slice(2)
```

4. **Make the Low-Level Call**

```javascript
const rawData = await web3.eth.call({
  to: contractAddress,
  data: data,
})
```

5. **Define the Returned Types**

```solidity
function getAllData(
        address _addr
    )
        public
        view
        returns (uint256, address, bool, string memory, bool, uint256)
    {
        return (
            storedUint,
            storedAddress,
            storedBool,
            storedString,
            addressMapping[_addr],
            creationDate
        );
    }
```

```javascript
const returnTypes = ["uint256", "address", "bool", "string", "bool", "uint256"]
```

6. **Decode the Raw Data With `decodeParameters`**

```javascript
const decodedData = web3.eth.abi.decodeParameters(returnTypes, rawData)
```

## Interacting with Setter Functions in Ethereum Smart Contracts Using Web3.js

### Example: Using `contract.methods`

```javascript
contract.methods.setStoredUint(value).send({
  from: owner,
})
```

Listening to transaction events using `.on` including `transactionHash`, `confirmation`, `receipt`, and `error`:

```javascript
contract.methods
  .setStoredUint(value)
  .send({
    from: owner,
  })
  .on("transactionHash", (txHash) => {
    console.log(`Transaction Hash: ${txHash}`)
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

### Example: Using `estimateGas`

```javascript
const value = boolInput.value === "true"
const gasEstimate = await contract.methods.setStoredBool(value).estimateGas({
  from: owner,
})

console.log(gasEstimate)

contract.methods.setStoredBool(value).send({
  from: owner,
  gas: gasEstimate + 1000,
})
```

### Example: Using `sendSignedTransaction`

```javascript
// 1. Get all the input value
const newUint = uintInput.value
const newAddress = addressInput.value
const newBool = boolInput.value
const newString = stringInput.value
const mappingAddress = mappingAddressInput.value
const mappingValue = mappingBoolInput.value

// 2. Get private key
const ownerPrivateKey = prompt("Enter your private key: ")
const ownerPublicAddress =
  web3.eth.accounts.privateKeyToAccount(ownerPrivateKey).address

// 3. Create contract method
const contractMethod = contract.methods.setAllData(
  newUint,
  newAddress,
  newBool,
  newString,
  mappingAddress,
  mappingValue
)

// 4. Prepare gas, gasPrice, encodeABI
const gas = await contractMethod.estimateGas({ from: ownerPublicAddress })
const gasPrice = await web3.eth.getGasPrice()
const data = contractMethod.encodeABI()

// 5. Create tx
const tx = {
  from: ownerPublicAddress,
  to: contractAddress,
  gas: gas, // estimateGas({})
  gasPrice: gasPrice,
  data: data, // encodeABI()
}

// 6. Sign transaction
const signedTx = await web3.eth.accounts.signTransaction(tx, ownerPrivateKey)

// 7. Send sign transaction
web3.eth
  .sendSignedTransaction(signedTx.rawTransaction)
  .on("transactionHash", function (hash) {
    console.log(`Transaction hash: ${hash}`)
  })
  .on("error", function (error) {
    console.error(`Transaction Error: `, error)
  })
```
