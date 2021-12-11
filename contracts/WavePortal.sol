// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";


contract WavePortal {
    uint256 totalWaves;
    uint256 totalPokes;

    /*
     * We will be using this below to help generate a random number
     */
    uint256 private seed;


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

    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user waved at us.
     */
    mapping(address => uint256) public lastInteractionPerAddress;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart (I guess)");

        /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {

        /*
         * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
         */
        require(
            lastInteractionPerAddress[msg.sender] + 1 minutes < block.timestamp,
            "Van minut"
        );

        /*
         * Update the current timestamp we have for the user
         */
        lastInteractionPerAddress[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;
        
        console.log("Random # generated: %d", seed);

        /*
         * Give a 50% chance that the user wins the prize.
         */
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "I'm broke"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }


        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function poke(string memory _message) public {
        totalPokes += 1;
        console.log("%s poked w/ message %s", msg.sender, _message);

        pokes.push(Poke(msg.sender, _message, block.timestamp));

        /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;
        
        console.log("Block Difficulty: %d", block.difficulty);
        console.log("Block Timestamp: %d", block.timestamp);
        console.log("Random # generated: %d", seed);

        /*
         * Give a 50% chance that the user wins the prize.
         */
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.00001 ether;
            require(
                prizeAmount <= address(this).balance,
                "I'm broke"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

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
