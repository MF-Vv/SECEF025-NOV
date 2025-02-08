# Web3 Event Listener

## Overview

This script sets up a WebSocket connection to listen for smart contract events in a local blockchain environment (Ganache). It listens for the `ContentChanged` event emitted by the smart contract and updates the webpage dynamically with the event details.

## Prerequisites

- Node.js installed

- Ganache running on `127.0.0.1:7545`

- A deployed smart contract that emits `ContentChanged` events

- Web3.js library included in the project

## Code Explanation

Set up the Web3 provider, contract, and ABI

```javascript
const WS_ENDPOINT = new Web3.providers.WebsocketProvider("ws://127.0.0.1:7545")
const wsWeb3 = new Web3(WS_ENDPOINT)

const contractAddress = "YOUR_CONTRACT_ADDRESS" // Replace with your deployed contract address
const abi = "YOUR_CONTRACT_ABI"
```

The `contract` variable is initialized with the `wsWeb3` provider.

```javascript
const contract = new wsWeb3.eth.Contract(abi, contractAddress)
```

This initializes a WebSocket provider to connect to a local blockchain running on Ganache.

```javascript
async function listenToEvents() {
  contract.events
    .ContentChanged()
    // Data
    .on("data", (event) => {
      const { newContent, userAddress } = event.returnValues
      document.getElementById(
        "message"
      ).innerText = `Last updated: ${new Date().toLocaleString()}`
      document.getElementById(
        "content"
      ).innerText = `Address: ${userAddress} changed to ${newContent}`
    })

    // Connected
    .on("connected", (subscriptionID) => {
      console.log(subscriptionID)
    })

    // Error
    .on("error", (err) => {
      document.getElementById("message").innerText = `Error: ${err}`
    })
}
```

This function listens for the `ContentChanged` event:

- When an event is detected, it extracts `newContent` and `userAddress` from `event.returnValues`.

- Updates the webpage elements with event details.

- Logs the subscription ID when connected.

- Displays an error message in case of connection failure.

## Usage

1. Run Ganache at `ws://127.0.0.1:7545`.

2. Include this script in your frontend application.
3. Ensure your smart contract emits `ContentChanged` events.
4. Call `listenToEvents()` to start listening for events.

## Troubleshooting

- Ensure that Ganache is running and accessible at `ws://127.0.0.1:7545`.

- Verify the contract ABI and address are correctly configured.

- Check browser console logs for errors related to WebSocket connections.
