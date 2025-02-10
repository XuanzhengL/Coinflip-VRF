// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Coinflip.sol";
import "../src/DirectFundingConsumer.sol";

contract DeployCoinflip is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy DirectFundingConsumer contract
        DirectFundingConsumer vrfRequestor = new DirectFundingConsumer();
        console.log("DirectFundingConsumer deployed at:", address(vrfRequestor));

        // Deploy Coinflip contract, passing the VRF contract address
        Coinflip coinflip = new Coinflip(address(vrfRequestor));
        console.log("Coinflip deployed at:", address(coinflip));

        // Prompt the user to manually send LINK to fund the VRF contract
        console.log("Please manually send 3 LINK to the DirectFundingConsumer contract at:", address(vrfRequestor));
        console.log("Once completed, proceed with the cast send command to request a random number.");

        vm.stopBroadcast();
    }
}


