// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IGuess {
    function guess(uint8 n) external payable;

    function isComplete() external view returns (bool);
}
