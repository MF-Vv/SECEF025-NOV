// Infura - Sepolia
// const WS_ENDPOINT = new Web3.providers.WebsocketProvider(
//   "wss://sepolia.infura.io/ws/v3/YOUR_INFURA_API_KEY"
// )

// Ganache
const WS_ENDPOINT = new Web3.providers.WebsocketProvider("ws://127.0.0.1:7545")

const web3 = new Web3(window.ethereum)
const wsWeb3 = new Web3(WS_ENDPOINT)

const contractAddress = "YOUR_CONTRACT_ADDRESS" // Replace with your deployed contract address
const abi = "YOUR_CONTRACT_ABI"
