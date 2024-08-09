// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { Parameters } from "../Parameters.sol";
import { MainRouter } from "../../src/MainRouter.sol";
import { TokenConfig } from "./TokenConfig.s.sol";

contract MainRouterConfig is Script, Parameters {
    function run() external {
        vm.startBroadcast();
        MainRouter mainRouter = MainRouter(payable(BSC_TESTNET_MAIN_ROUTER));

        mainRouter.setAllowedSender(BSC_TESTNET_DEPOSITOR, true);
        mainRouter.setAllowedSender(ETHEREUM_SEPOLIA_DEPOSITOR, true);
        mainRouter.setAllowedSender(OPTIMISM_SEPOLIA_DEPOSITOR, true);
        mainRouter.setAllowedSender(BSC_TESTNET_MINTER, true);
        mainRouter.setAllowedSender(ETHEREUM_SEPOLIA_MINTER, true);
        mainRouter.setAllowedSender(OPTIMISM_SEPOLIA_MINTER, true);
        
        mainRouter.setBinanceDepositor(BSC_TESTNET_DEPOSITOR);
        mainRouter.setBinanceMinter(BSC_TESTNET_MINTER);
        
        vm.stopBroadcast();
        
    }
}
