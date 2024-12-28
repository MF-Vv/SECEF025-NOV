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

## Interacting with Ethereum Smart Contracts Using Web3.js

This guide covers how to interact with an Ethereum smart contract using Web3.js. The contract in question is designed for storing and managing various data types and user balances.

### Example Code Using `contract.methods`

```javascript
const storedUint = await contract.methods.getStoredUint().call()

const storedAddress = await contract.methods.getStoredAddress().call()
```

### Example Code Using Low-Level Call `.call({})`

This example demonstrates how to use low-level calls with Web3.js to interact with the smart contract.

1. **Check if an Address is Valid**

```javascript
web3.utils.isAddress(address)
```

2. **Encode the Function Signature**

```javascript
web3.eth.abi.encodeFunctionSignature("getAddressMapping(address)")
```

3. **Encode the Function Parameter**

```javascript
const encodedParameter = web3.eth.abi.encodeParameter("address", address)
```

4. **Combine the Function Signature and Encoded Parameter**

```javascript
const data = functionSignature + encodedParameter.slice(2)
```

5. **Make the Low-Level Call**

```javascript
const rawData = await web3.eth.call({
  to: contractAddress,
  data: data,
})
```

6. **Decode the Returned Data**

```javascript
const decodedData = web3.eth.abi.decodeParameter("bool", rawData)
```

This approach allows you to interact with the contract at a lower level, providing more control over the data being sent and received.

## Description

A contract for storing and managing various data types and user balances.

This contract allows the owner to store and manage different types of data including uint256, address, bool, and string.

It also maintains mappings for addresses and user balances. The contract includes functions for setting and getting these values, as well as handling Ether transactions and withdrawals.

## 1. State Variables

- `storedUint`: A uint256 value stored in the contract.
- `storedAddress`: An address stored in the contract.
- `storedBool`: A boolean value stored in the contract.
- `storedString`: A string stored in the contract.
- `creationDate`: The timestamp when the contract was created.
- `addressMapping`: A mapping of addresses to boolean values.
- `userBalances`: A mapping of addresses to their respective balances.
- `owner`: The owner of the contract.

## 2. Modifiers

The `onlyOwner`: Restricts function access to the contract owner.

## 3. Constructor

Initializes the contract with given values and sets the deployer as the owner.

## 4. Getter Functions

- `getStoredUint()`: Returns the stored uint256 value.
- `getStoredAddress()`: Returns the stored address.
- `getStoredBool()`: Returns the stored boolean value.
- `getStoredString()`: Returns the stored string.
- `getAddressMapping(address)`: Returns the boolean value for a given address in the address mapping.
- `getCreateDate()`: Returns the creation date of the contract.
- `getAllData(address)`: Returns all stored data and the boolean value for a given address in the address mapping.
- `getUserBalance(address)`: Returns the balance of a given user.
- `getContractBalance()`: Returns the balance of the contract.

## 5. Setter Functions

- `setStoredUint(uint256)`: Sets a new uint256 value (onlyOwner).
- `setStoredAddress(address)`: Sets a new address (onlyOwner).
- `setStoredBool(bool)`: Sets a new boolean value (onlyOwner).
- `setStoredString(string)`: Sets a new string (onlyOwner).
- `setAddressMapping(address, bool)`: Sets a new boolean value for a given address in the address mapping (onlyOwner).
- `setAllData(uint256, address, bool, string, address, bool)`: Sets all data values (onlyOwner).

## 6. Ether Handling

- `receive() external payable`: Allows the contract to receive Ether.
- `receiveFunds() public payable`: Increases the balance of the sender by the received Ether amount.
- `fallback() external payable`: Reverts any invalid calls or calls with data.

## 7. Withdrawal Function

- `withdraw(uint256)`: Allows users to withdraw a specified amount of Ether from their balance.

## 8. Completed Version

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataStorage {
    // Declare state variables
    uint256 private storedUint;
    address private storedAddress;
    bool private storedBool;
    string private storedString;
    uint256 public creationDate;

    mapping(address => bool) private addressMapping;
    mapping(address => uint256) private userBalances;

    // Owner of the contract
    address private owner;

    // Modifier to restrict functions to owner only
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Access Denied: Only the contract owner can perform this action."
        );
        _;
    }

    // Constructor to initialize the values
    constructor(
        uint256 _storedUint,
        address _storedAddress,
        bool _storedBool,
        string memory _storedString
    ) {
        storedUint = _storedUint;
        storedAddress = _storedAddress;
        storedBool = _storedBool;
        storedString = _storedString;
        owner = msg.sender; // Set the deployer as the owner
        creationDate = block.timestamp;
    }

    // ===========================
    // Getter Functions
    // ===========================
    function getStoredUint() public view returns (uint256) {
        return storedUint;
    }

    function getStoredAddress() public view returns (address) {
        return storedAddress;
    }

    function getStoredBool() public view returns (bool) {
        return storedBool;
    }

    function getStoredString() public view returns (string memory) {
        return storedString;
    }

    function getAddressMapping(address _addr) public view returns (bool) {
        return addressMapping[_addr];
    }

    function getCreateDate() public view returns (uint256) {
        return creationDate;
    }

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

    // ===========================
    // Balances - Getter Functions (Others)
    // ===========================
    function getUserBalance(address _user) public view returns (uint256) {
        return userBalances[_user];
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // ===========================
    // Setter Functions
    // ===========================

    function setStoredUint(uint256 _newUint) public onlyOwner {
        storedUint = _newUint;
    }

    function setStoredAddress(address _newAddress) public onlyOwner {
        storedAddress = _newAddress;
    }

    function setStoredBool(bool _newBool) public onlyOwner {
        storedBool = _newBool;
    }

    function setStoredString(string memory _newString) public onlyOwner {
        storedString = _newString;
    }

    function setAddressMapping(address _addr, bool _value) public onlyOwner {
        addressMapping[_addr] = _value;
    }

    function setAllData(
        uint256 _newUint,
        address _newAddress,
        bool _newBool,
        string memory _newString,
        address _addr,
        bool _value
    ) public onlyOwner {
        storedUint = _newUint;
        storedAddress = _newAddress;
        storedBool = _newBool;
        storedString = _newString;
        addressMapping[_addr] = _value;
    }

    // ===========================
    // Receive Funds
    // ===========================
    receive() external payable {
        // The contract now accepts Ether. Optionally, you can implement logic to handle the funds.
        receiveFunds();
    }

    function receiveFunds() public payable {
        userBalances[msg.sender] += msg.value;
    }

    // Fallback function to reject any calls with data or invalid function signatures
    fallback() external payable {
        revert("Invalid call: Reverting due to data or unmatched function.");
    }

    // ===========================
    // Withdrawal Function
    // ===========================
    function withdraw(uint256 _amount) public {
        uint256 userBalance = userBalances[msg.sender];

        require(userBalance >= _amount, "Insufficient balance");

        userBalances[msg.sender] -= _amount;

        payable(msg.sender).transfer(_amount);
    }

}
```
