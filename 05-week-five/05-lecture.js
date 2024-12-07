/**
 *  ---------------------------------------------
 *  |             Week Five Lecture             |
 *  ---------------------------------------------
 *  |                                           |
 *  |     -> Smart Contract Communication       |
 *  |                                           |
 *  ---------------------------------------------
 */

/**
 * 1. Environment Setup:
 *      - Enable ganache private blockchain
 *      - Enter node environment
 *      - Import Web3 & web3
 *
 * 2. Directly Call To Smart Contract With Function Signature
 *      - Convert the raw hexadecimal value using hexToNumber & hexToNumberString
 *
 * 3. Generate Function Signature Based On The String Value
 *
 * 4. Setup Contract
 *      - Copy ABI from remix and contract address
 *
 * 5. Use Contract To Call Getter & Setter Function In Solidity Contract
 *
 */

web3.eth
  .call({
    from: "0xBa6aB02C8a7cF2885B2E72fd83F91c3F9541Bd80", // Ganache address
    to: "0x0Bb669fE97Fb760784Ee541fC8A28c70F73706Fc", // Contract address
    data: "0xf2c9ecd8", // Function Signature
  })
  .then((result) => console.log(web3.utils.hexToNumberString(result)))

web3.utils.hexToNumber(
  "0x0000000000000000000000000000000000000000000000000000000000000891"
)

// Generate Function Signature
web3.utils.keccak256("getNumber()").substr(0, 10)
web3.utils.keccak256("getNumber()").slice(0, 10)
web3.utils.sha3("getNumber()").slice(0, 10)

// Setup Contract Connection
let contract = new web3.eth.Contract(
  [
    {
      inputs: [
        {
          internalType: "uint256",
          name: "_num",
          type: "uint256",
        },
      ],
      stateMutability: "nonpayable",
      type: "constructor",
    },
    {
      inputs: [],
      name: "getNumber",
      outputs: [
        {
          internalType: "uint256",
          name: "",
          type: "uint256",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "uint256",
          name: "_num",
          type: "uint256",
        },
      ],
      name: "setNumber",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
  ], // Your ABI
  "0x0Bb669fE97Fb760784Ee541fC8A28c70F73706Fc" // Contract Address
)

// Call Contract's Getter Function Method
contract.methods
  .getNumber()
  .call()
  .then((output) => console.log(output))

// Call Contract's Setter Function Method
contract.methods
  .setNumber(2000)
  .send({
    from: "0xB21d27219D42DfDE98547977fC01b236316f8D9C", // Any Ganache Public Address
  })
  .then((output) => console.log(output))
