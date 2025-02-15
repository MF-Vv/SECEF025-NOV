// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    uint public candidateA;
    uint public candidateB;

    function voteA() public {
        candidateA += 1;
    }

    function voteB() public {
        candidateB += 1;
    }
}
