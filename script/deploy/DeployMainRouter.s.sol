// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { Parameters } from "../Parameters.sol";
import { MainRouter } from "../../src/MainRouter.sol";
import { TokenConfig } from "../config/TokenConfig.s.sol";


contract DeployMainRouter is Script, Parameters {
    function run() external returns (MainRouter mainRouter) {
        vm.startBroadcast();
        mainRouter = new MainRouter(BSC_TESTNET_CHAIN_SELECTOR, BSC_TESTNET_CCIP_ROUTER, BSC_TESTNET_FUNCTIONS_ROUTER, BSC_TESTNET_DON_ID);
        mainRouter.setSubscriptionID(FUNCTIONS_SUBSCRIPTION_ID);
        
        TokenConfig tokenConfig = new TokenConfig();

        addAllowedToken(mainRouter, tokenConfig.getBscTestnetToken());
        addAllowedToken(mainRouter, tokenConfig.getEthereumSepoliaToken());
        addAllowedToken(mainRouter, tokenConfig.getOptimismSepoliaToken());

        mainRouter.setAllowedDestinationChain(BSC_TESTNET_CHAIN_SELECTOR, true);
        mainRouter.setAllowedDestinationChain(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, true);
        mainRouter.setAllowedDestinationChain(OPTIMISM_SEPOLIA_CHAIN_SELECTOR, true);

        mainRouter.setAllowedSourceChain(BSC_TESTNET_CHAIN_SELECTOR, true);
        mainRouter.setAllowedSourceChain(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, true);
        mainRouter.setAllowedSourceChain(OPTIMISM_SEPOLIA_CHAIN_SELECTOR, true);

        vm.stopBroadcast();
    }

    function addAllowedToken(MainRouter mainRouter, TokenConfig.Token memory token) public {
        mainRouter.addAllowedToken(token.wbtc.chainSelector, token.wbtc.token, token.wbtc.priceFeed, 18);
        mainRouter.addAllowedToken(token.weth.chainSelector, token.weth.token, token.weth.priceFeed, 18);
        mainRouter.addAllowedToken(token.stone.chainSelector, token.stone.token, token.stone.priceFeed, 18);
        mainRouter.addAllowedToken(token.wbnb.chainSelector, token.wbnb.token, token.wbnb.priceFeed, 18);
        mainRouter.addAllowedToken(token.usdc.chainSelector, token.usdc.token, token.usdc.priceFeed, 6);
        mainRouter.addAllowedToken(token.busd.chainSelector, token.busd.token, token.busd.priceFeed, 6);
    }
}