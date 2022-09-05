// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract NicknameSolution is Script {
    address private CAPTURE_THE_ETHER_ADDRESS = vm.envAddress("ADDRESS");

    function setUp() public {}

    function run() public {
        bytes32 nickname = bytes32("foundry");
        vm.broadcast();
        (bool success,) = CAPTURE_THE_ETHER_ADDRESS.call(abi.encodeWithSignature("setNickname(bytes32)", nickname));
        require(success, "call failed");
    }
}
