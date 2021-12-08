// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

// WavePortal address: 0x831F6aC8f19940B8a6E3E831198680Ff128aa00A

contract WavePortal {
    uint256 totalWaves;
    uint256 totalPokes;

    // Events
    event NewWave(address indexed from, uint256 timestamp, string message);
    event NewPoke(address indexed from, uint256 timestamp, string message);

    // Structs
    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }
    struct Poke {
        address poker; // The address of the user who poked.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user poked.
    }

    // Global vars that are stored in blockchain
    Wave[] waves;
    Poke[] pokes;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart (I guess)");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function poke(string memory _message) public {
        totalPokes += 1;
        console.log("%s poked w/ message %s", msg.sender, _message);

        pokes.push(Poke(msg.sender, _message, block.timestamp));

        emit NewPoke(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getTotalPokes() public view returns (uint256) {
        console.log("We have %d total pokes!", totalPokes);
        return totalPokes;
    }

    function getAllPokes() public view returns (Poke[] memory) {
        console.log("We have %d total pokes!", totalPokes);
        return pokes;
    }
}
