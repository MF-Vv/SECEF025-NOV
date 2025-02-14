// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TenDemo {
    mapping(address => string) public contentList;

    event ContentChanged(string newContent, address indexed userAddress);

    // Function to set a name for the calling address
    function setContent(string calldata _content) public {
        contentList[msg.sender] = _content;
        emit ContentChanged(_content, msg.sender);
    }

    // Function to get a name from an address
    function getContent(address _address) public view returns (string memory) {
        return contentList[_address];
    }
}
