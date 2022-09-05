// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract CallMeSolution is Script {
    address private CAll_ME_ADDRESS = vm.envAddress("ADDRESS");

    function setUp() public {}

    function run() public {
        vm.broadcast();
        (bool success,) = CAll_ME_ADDRESS.call(abi.encodeWithSignature("callme()"));
        require(success, "call failed");
    }
}
