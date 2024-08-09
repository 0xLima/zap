// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { Parameters } from "../Parameters.sol";
import { MainRouter } from "../../src/MainRouter.sol";
import { TokenConfig } from "../config/TokenConfig.s.sol";

contract SetBinance is Script, Parameters {
    function run() external {
        MainRouter mainRouter = MainRouter(payable(BSC_TESTNET_MAIN_ROUTER));
        vm.startBroadcast();
        mainRouter.setBinanceDepositor(BSC_TESTNET_DEPOSITOR);
        mainRouter.setBinanceMinter(BSC_TESTNET_MINTER);
        vm.stopBroadcast();
        
    }
}
