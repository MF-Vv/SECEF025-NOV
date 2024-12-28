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
