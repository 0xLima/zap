// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library OracleLib {
    error OracleLib__StalePrice();

    uint256 public constant TIMEOUT = 24 hours;

    function checkStaleTime(AggregatorV3Interface chainlinkFeed) public view returns (uint256) {
        (, , , uint256 updatedAt, ) = chainlinkFeed.latestRoundData();
        uint256 secondsSince = block.timestamp - updatedAt;
        return secondsSince;
    }

    function checkLatestRoundData(AggregatorV3Interface chainlinkFeed)
        public
        view
        returns (uint80, int256, uint256, uint256, uint80)
    {
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            chainlinkFeed.latestRoundData();
        return (roundId, answer, startedAt, updatedAt, answeredInRound);
    }

    function staleCheckLatestRoundData(AggregatorV3Interface chainlinkFeed)
        public
        view
        returns (uint80, int256, uint256, uint256, uint80)
    {
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            chainlinkFeed.latestRoundData();

        if (updatedAt == 0 || answeredInRound < roundId) {
            revert OracleLib__StalePrice();
        }
        uint256 secondsSince = block.timestamp - updatedAt;
        if (secondsSince > TIMEOUT) revert OracleLib__StalePrice();

        return (roundId, answer, startedAt, updatedAt, answeredInRound);
    }

    function getTimeout(AggregatorV3Interface /* chainlinkFeed */ ) public pure returns (uint256) {
        return TIMEOUT;
    }
}