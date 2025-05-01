// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

abstract contract Ownable {
    address public owner;

    modifier onlyOwner() {
        // #1
        if (msg.sender != owner) {
            revert("NAO AUTORIZADO");
        } else {
            // #2
            _;
        }
    }

    function transferOwnership(address newOwner) public onlyOwner {
        // #3
        owner = newOwner;
    }

    constructor(address _owner) {
        owner = _owner;
    }
}
