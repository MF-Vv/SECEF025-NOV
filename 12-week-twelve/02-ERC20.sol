// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyTokenDemo is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupply);
    }

    function mintToken(uint256 amount) public {
        _mint(msg.sender, amount);
    }

    function destroy(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient Token!");
        _burn(msg.sender, amount);
    }
}
