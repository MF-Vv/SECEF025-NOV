// MathLibrary.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MathLibrary {
    // Stateless function to add two numbers
    function add(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }
}

// Calculator.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MathLibrary.sol";

contract Calculator {
    uint256 public result;

    // Using the library's add function
    function addNumbers(uint256 a, uint256 b) external {
        result = MathLibrary.add(a, b); // Calls the library's function
    }
}
