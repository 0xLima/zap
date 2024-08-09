// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20Burnable, ERC20 } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract ZXP is ERC20Burnable, Ownable {
    error ZXP__AmountMustBeMoreThanZero();
    error ZXP__BurnAmountExceedsBalance();
    error ZXP__NotZeroAddress();

    constructor() ERC20("ZXP", "ZXP") Ownable(msg.sender) {

    }

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if (_amount <= 0){
            revert ZXP__AmountMustBeMoreThanZero();
        }
        if (balance < _amount){
            revert ZXP__BurnAmountExceedsBalance();
        }
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns (bool){
        if (_to == address(0)){
            revert ZXP__NotZeroAddress();
        }

        if (_amount <= 0){
            revert ZXP__AmountMustBeMoreThanZero();
        }

        _mint(_to, _amount);
        return true;
    }
}
