// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 totalPokes;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart (I guess)");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
    }

    function poke() public {
        totalPokes += 1;
        console.log("%s has poked you!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getTotalPokes() public view returns (uint256) {
        console.log("We have %d total pokes!", totalPokes);
        return totalPokes;
    }
}
