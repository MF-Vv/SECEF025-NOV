// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define an interface with function declarations
interface IGreeting {
    function setGreeting(string memory) external;
    function getGreeting() external view returns (string memory);
    event GreetingUpdated(address from, address to, uint256 value);
}

// Base contract implementing the IGreeting interface
contract Greeter is IGreeting {
    string internal greeting;

    // Function marked as virtual to allow derived contracts to override it
    function setGreeting(string memory _greeting) public virtual {}

    function getGreeting() public view returns (string memory) {
        return greeting;
    }
}

// Derived contract that overrides the setGreeting function
contract CustomGreeting is Greeter {
    // Function marked as override to specify it overrides a virtual function
    function setGreeting(string memory _greeting) public virtual override {
        greeting = string(abi.encodePacked("New func: ", _greeting));
        emit GreetingUpdated(msg.sender, msg.sender, 100);
    }
}

// Further derived contract that also overrides the setGreeting function
contract FinalGreeting is CustomGreeting {
    // Function marked as override to specify it overrides a virtual function
    function setGreeting(string memory _greeting) public virtual override {
        greeting = string(abi.encodePacked("New func: ", _greeting));
        emit GreetingUpdated(msg.sender, msg.sender, 100);
    }
}
