
# Week Six Lecture

  

## Basic Implementation with HTML/JS

  

### 1. Environment Setup:

-  **Enable Ganache private blockchain**

-  **Import Web3.js library**:

```html
  <script  src="../node_modules/web3/dist/web3.min.js"></script>
```

-  **Connect to Ganache**:

```javascript
   const  web3 = new  Web3("http://127.0.0.1:7545");
```

  

### 2. Key Concepts Covered:

- Setting up a connection to a local Ethereum node using Web3.js

- Interacting with the blockchain through functions such as `web3.eth.getAccounts()` to fetch accounts

- Displaying account balances using Web3.js in a simple HTML interface

  

### 3. Steps to Run:

- Ensure **Ganache** is running on your local machine with an available Ethereum network

- Open the HTML file in a browser to interact with the blockchain

- Use the buttons in the UI to fetch Ethereum accounts and check their balances

  

### 4. Expected Outcomes:

- User should be able to retrieve Ethereum accounts from Ganache

- User should be able to get the balance of Ethereum accounts in ETH