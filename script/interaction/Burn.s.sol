// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { TokenConfig } from "../config/TokenConfig.s.sol";
import { ERC20Mock } from "../Mocks/ERC20Mock.sol";
import { Minter } from "../../src/Minter.sol";
import { ChainConfig } from "../config/ChainConfig.s.sol";
import { ZXP } from "../../src/ZXP.sol";

contract Burn is Script {
    function burn(uint256 _amount, uint256 _amountEther) external {
        ChainConfig config = new ChainConfig();
        ChainConfig.ChainComponent memory chain = config.run();

        ZXP zxp = Minter(payable(chain.minter)).getZxp();

        vm.startBroadcast();
        zxp.approve(payable(chain.minter), _amount);
        Minter(payable(chain.minter)).burn{value: _amountEther}( _amount);
        vm.stopBroadcast();
    }
}