# MetaMask JSON-RPC API Methods

This document provides an overview of the MetaMask JSON-RPC API methods utilized in the example code.

## Methods

### `eth_requestAccounts`

```javascript
const accounts = await window.ethereum.request({
  method: "eth_requestAccounts",
})

console.log(accounts)
```

- **Returns**: A `Promise` that resolves to an array of Ethereum account addresses ( `string[]`) provided by the user.

- Description: Requests that the user provide an Ethereum address to be identified by. This method is specified by EIP-1102. Internally, this method calls `wallet_requestPermissions` for permission to call `eth_accounts`.

### `eth_accounts`

```javascript
const availableAccounts = await window.ethereum.request({
  method: "eth_accounts",
})

console.log(availableAccounts)
```

- **Returns**: A `Promise` that resolves to an array of Ethereum account addresses (`string[]`) currently available and authorized for the application.

- Description: Retrieves a list of Ethereum accounts associated with the user.

### `eth_chainId`

```javascript
const chainId = await window.ethereum.request({ method: "eth_chainId" })

console.log(chainId)
```

- **Returns**: A `Promise` that resolves to a string representing the current chain ID in hexadecimal format (`string`).

- Description: Obtains the current chain ID.

### `eth_gasPrice`

```javascript
const gasPrice = await window.ethereum.request({ method: "eth_gasPrice" })

console.log(gasPrice)
```

- **Returns**: A `Promise` that resolves to a string representing the current gas price in wei, expressed in `hexadecimal format`.

- Description: Retrieves the current gas price in wei.

### `wallet_switchEthereumChain`

```javascript
// Ganache chain ID
const ganacheChainId = "0x539"

const output = await window.ethereum.request({
  method: "wallet_switchEthereumChain",
  params: [{ chainId: ganacheChainId }],
})
```

- **Returns**: A `Promise` that resolves if the wallet successfully switches to the specified chain or rejects with an error if the chain is not available or the user denies the request.
- Description: Asks the user to switch to a specified Ethereum chain.

- **Note**: This method is part of EIP-3326. To handle cases where the chain is not added to the wallet, use `wallet_addEthereumChain` to prompt the user to add the chain before switching.

### `wallet_addEthereumChain`

```javascript
const chainInfo = {
  chainId: "0x539",
  chainName: "Ganache 7545",
  rpcUrls: ["http://127.0.0.1:7545"],
  iconUrls: [],
  nativeCurrency: {
    name: "ETH",
    symbol: "ETH",
    decimals: 18,
  },
  blockExplorerUrls: [],
}

const output = await window.ethereum.request({
  method: "wallet_addEthereumChain",
  params: [chainInfo],
})
```

- **Returns**: A `Promise` that resolves if the chain is successfully added to the wallet or rejects with an error if the user denies the request or the chain configuration is invalid.

- Description: Prompts the user to add a specified Ethereum chain.

- Parameters:

  - **`chainId`** (string): The unique identifier for the blockchain network, in hexadecimal format.

  - **`chainName`** (string): A human-readable name for the chain.

  - **`rpcUrls`** (array): A list of RPC endpoints for interacting with the chain.

  - **`iconUrls`**(array): (Optional) URLs pointing to chain icons.

  - **`nativeCurrency`** (object): Information about the chain's native currency, including its **`name`**, **`symbol`**, and **`decimals`**.

  - **`blockExplorerUrls`** (array): (Optional) URLs to block explorers for the chain.

### `personal_sign`

```javascript
// Get accounts
const accounts = await window.ethereum.request({
  method: "eth_accounts",
})

const message = `Please sign this message to confirm your identity.`

const hexMessage = web3.utils.utf8ToHex(message)

const signature = await window.ethereum.request({
  method: "personal_sign",
  params: [hexMessage, accounts[0]],
})
```

- **Returns**: A `Promise` that resolves to a string containing the signed message's signature.

- Description: Requests the user to sign a message with their Ethereum account.

- Parameters:

  - **`hexMessage`** (string): The message to be signed, converted to a hexadecimal format.

  - **`accounts[0]`** (string): The Ethereum address of the account signing the message.

# Official Documentation

- [MetaMask Documentation](https://docs.metamask.io/guide/rpc-api.html#table-of-contents)
- [EIP-1193](https://eips.ethereum.org/EIPS/eip-1193)
