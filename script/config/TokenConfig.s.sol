// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { Parameters } from "../Parameters.sol";
import { ERC20Mock } from "../Mocks/ERC20Mock.sol";

contract TokenConfig is Script, Parameters {
    struct BaseToken {
        uint64 chainSelector;
        address token;
        address priceFeed;
    }

    struct Token {
        BaseToken wbtc;
        BaseToken weth;
        BaseToken stone;
        BaseToken wbnb;
        BaseToken usdc;
        BaseToken busd;
    }


    function run() external view returns (Token memory token){
        if (block.chainid == BSC_TESTNET_CHAIN_ID) {
            return getBscTestnetToken();
        }
        else if (block.chainid == ETHEREUM_SEPOLIA_CHAIN_ID) {
            return getEthereumSepoliaToken();
        }
        else if (block.chainid == OPTIMISM_SEPOLIA_CHAIN_ID) {
            return getOptimismSepoliaToken();
        }
    }

    function getBscTestnetToken() public pure returns (Token memory token){
        token.wbtc = BaseToken(BSC_TESTNET_CHAIN_SELECTOR, BSC_TESTNET_WBTC, BTC_PRICE_FEED);
        token.weth = BaseToken(BSC_TESTNET_CHAIN_SELECTOR, BSC_TESTNET_WETH, ETH_PRICE_FEED);
        token.stone = BaseToken(BSC_TESTNET_CHAIN_SELECTOR, BSC_TESTNET_STONE, STONE_PRICE_FEED);
        token.wbnb =
BaseToken(BSC_TESTNET_CHAIN_SELECTOR, BSC_TESTNET_WBNB, BNB_PRICE_FEED);
        token.usdc = BaseToken(BSC_TESTNET_CHAIN_SELECTOR, BSC_TESTNET_USDC, USDC_PRICE_FEED);
        token.busd = BaseToken(BSC_TESTNET_CHAIN_SELECTOR, BSC_TESTNET_BUSD, BUSD_PRICE_FEED);
    }

    function getEthereumSepoliaToken() public pure returns (Token memory token){
        token.wbtc = BaseToken(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, ETHEREUM_SEPOLIA_WBTC, BTC_PRICE_FEED);
        token.weth = BaseToken(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, ETHEREUM_SEPOLIA_WETH, ETH_PRICE_FEED);
        token.stone = BaseToken(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, ETHEREUM_SEPOLIA_STONE, STONE_PRICE_FEED);
        token.wbnb = BaseToken(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, ETHEREUM_SEPOLIA_WBNB, BNB_PRICE_FEED);
        token.usdc = BaseToken(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, ETHEREUM_SEPOLIA_USDC, USDC_PRICE_FEED);
        token.busd = BaseToken(ETHEREUM_SEPOLIA_CHAIN_SELECTOR, ETHEREUM_SEPOLIA_BUSD, BUSD_PRICE_FEED);
    }

    function getOptimismSepoliaToken() public pure returns (Token memory token){
        token.wbtc = BaseToken(OPTIMISM_SEPOLIA_CHAIN_SELECTOR, OPTIMISM_SEPOLIA_WBTC, BTC_PRICE_FEED);
        token.weth = BaseToken(OPTIMISM_SEPOLIA_CHAIN_SELECTOR, OPTIMISM_SEPOLIA_WETH, ETH_PRICE_FEED);
        token.link = BaseToken(OPTIMISM_SEPOLIA_CHAIN_SELECTOR, OPTIMISM_SEPOLIA_STONE, STONE_PRICE_FEED);
        token.wbnb = BaseToken(OPTIMISM_SEPOLIA_CHAIN_SELECTOR, OPTIMISM_SEPOLIA_WBNB, BNB_PRICE_FEED);
        token.usdc = BaseToken(OPTIMISM_SEPOLIA_CHAIN_SELECTOR, OPTIMISM_SEPOLIA_USDC, USDC_PRICE_FEED);
        token.busd = BaseToken(OPTIMISM_SEPOLIA_CHAIN_SELECTOR, OPTIMISM_SEPOLIA_BUSD, BUSD_PRICE_FEED);
    }
}