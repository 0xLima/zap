// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import { Parameters } from "../Parameters.sol";

contract ChainConfig is Script, Parameters {
    struct ChainComponent {
        address depositor;
        address minter;
        uint64 chainSelector;
        address router;
    }

    function run() external view returns (ChainComponent memory chain) {
        if (block.chainid == BSC_TESTNET_CHAIN_ID) {
            chain = getBscTestnetChain();
        }
        if (block.chainid == ETHEREUM_SEPOLIA_CHAIN_ID) {
            chain = getEthereumSepoliaChain();
        }
        if (block.chainid == OPTIMISM_SEPOLIA_CHAIN_ID) {
            chain = getOptimismSepoliaChain();
        }
    }

    function getBscTestnetChain() public pure returns (ChainComponent memory chain) {
        chain.depositor = BSC_TESTNET_DEPOSITOR;
        chain.minter = BSC_TESTNET_MINTER;
        chain.chainSelector = BSC_TESTNET_CHAIN_SELECTOR;
        chain.router = BSC_TESTNET_CCIP_ROUTER;
    }

    function getEthereumSepoliaChain() public pure returns (ChainComponent memory chain) {
        chain.depositor = ETHEREUM_SEPOLIA_DEPOSITOR;
        chain.minter = ETHEREUM_SEPOLIA_MINTER;
        chain.chainSelector = ETHEREUM_SEPOLIA_CHAIN_SELECTOR;
        chain.router = ETHEREUM_SEPOLIA_CCIP_ROUTER;
    }

    function getOptimismSepoliaChain() public pure returns (ChainComponent memory chain) {
        chain.depositor = OPTIMISM_SEPOLIA_DEPOSITOR;
        chain.minter = OPTIMISM_SEPOLIA_MINTER;
        chain.chainSelector = OPTIMISM_SEPOLIA_CHAIN_SELECTOR;
        chain.router = OPTIMISM_SEPOLIA_CCIP_ROUTER;
    }


}