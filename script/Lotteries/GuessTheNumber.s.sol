// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "./IGuess.sol";

contract GuessTheNumberSolution is Script {
    IGuess private guessTheNumber = IGuess(vm.envAddress("ADDRESS"));
    uint8 answer = 42;

    function setUp() public {}

    function run() public {
        vm.broadcast();
        guessTheNumber.guess{value: 1 ether}(answer);
        require(guessTheNumber.isComplete());
    }
}
