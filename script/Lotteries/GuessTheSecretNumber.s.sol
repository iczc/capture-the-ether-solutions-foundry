// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "./IGuess.sol";

contract GuessTheSecretNumberSolution is Script {
    IGuess private guessTheSecretNumber = IGuess(vm.envAddress("ADDRESS"));
    uint8 answer;

    function setUp() public {
        bytes32 answerHash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;
        for (uint8 i = 0; i <= type(uint8).max; i++) {
            if (keccak256(abi.encodePacked(i)) == answerHash) {
                answer = i;
                break;
            }
        }
        console.log(answer);
    }

    function run() public {
        vm.broadcast();
        guessTheSecretNumber.guess{value: 1 ether}(answer);
        require(guessTheSecretNumber.isComplete());
    }
}
