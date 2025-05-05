// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Ownable} from "./Ownable.sol";
import {Pausable} from "./Pausable.sol";
import {ReentrancyGuard} from "./ReentrancyGuard.sol";

contract Token is Ownable, Pausable, ReentrancyGuard {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;

    // | address | uint256 |
    // | lucas   |  90     |
    // | Thiago  |  777    |

    constructor(string memory _name, string memory _symbol, uint8 _decimals) Pausable(false) Ownable(msg.sender) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }

    function transfer(address _to, uint256 _value) public whenNotPaused returns (bool success) {
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        return true;
    }

    function mint() public {
        uint256 amount = 1000 * 1e18;

        balanceOf[msg.sender] += amount;
        totalSupply += amount;
    }

    function burn(address user, uint256 amount) public onlyOwner {
        balanceOf[user] -= amount;
    }

    function unburn(address user, uint256 amount) public onlyOwner {
        balanceOf[user] += amount;
    }
}
