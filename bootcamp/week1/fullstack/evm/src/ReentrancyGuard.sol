// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

abstract contract ReentrancyGuard {
    bool public lock = false;

    modifier noReentrant() {
        if (lock == true) {
            revert("NO_REENTRANCY");
        }

        lock = true;
        _;
        lock = false;
    }
}
