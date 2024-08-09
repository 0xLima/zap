// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { Parameters } from "../Parameters.sol";
import { MainRouter } from "../../src/MainRouter.sol";
import { Minter } from "../../src/Minter.sol";
import { ChainConfig } from "../config/ChainConfig.s.sol";

contract DeployMinter is Script, Parameters {
    function run() external returns (Minter minter) {
        ChainConfig config = new ChainConfig();
        ChainConfig.ChainComponent memory component = config.run();

        address router = component.router;
        uint64 chainSelector = component.chainSelector;

        vm.startBroadcast();
        minter = new Minter(chainSelector, router, BSC_TESTNET_CHAIN_SELECTOR, BSC_TESTNET_MAIN_ROUTER);
        
        minter.setAllowedDestinationChain(BSC_TESTNET_CHAIN_SELECTOR, true);
        minter.setAllowedSourceChain(BSC_TESTNET_CHAIN_SELECTOR, true);
        minter.setAllowedSender(BSC_TESTNET_MAIN_ROUTER, true);

        vm.stopBroadcast();
    }
}