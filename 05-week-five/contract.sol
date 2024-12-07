// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WeekFiveDemoOne {

    uint256 private number;
    constructor(uint256 _num) {
        number = _num;
    }
    function getNumber() public view returns (uint256) {
        return number;
    }
    function setNumber(uint256 _num) public {
        number = _num;
    }
}