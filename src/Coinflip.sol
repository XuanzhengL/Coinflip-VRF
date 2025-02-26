// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {DirectFundingConsumer} from "./DirectFundingConsumer.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Coinflip is Ownable {
    mapping(address => uint256) public playerRequestID;
    mapping(address => uint8[3]) public bets;
    DirectFundingConsumer private vrfRequestor;

    address private constant LINK_TOKEN = 0x779877A7B0D9E8603169DdbD7836e478b4624789; // LINK token address

    constructor(address _vrfRequestor) Ownable(msg.sender) {
        vrfRequestor = DirectFundingConsumer(payable(_vrfRequestor));
    }

    /// @notice Fund the VRF instance with 5 LINK tokens.
    /// @dev Only the owner can fund the VRF contract.
    function fundOracle() external onlyOwner returns (bool) {
        uint256 amount = 5 * 10**18;
        bool sent = IERC20(LINK_TOKEN).transfer(address(vrfRequestor), amount);
        require(sent, "Failed to fund VRF");
        return sent;
    }

    /// @notice User guesses three flips, either a 1 or a 0.
    /// @param guesses User's guess for three flips (0 or 1).
    function userInput(uint8[3] calldata guesses) external {
        require(guesses[0] == 0 || guesses[0] == 1, "Invalid input");
        require(guesses[1] == 0 || guesses[1] == 1, "Invalid input");
        require(guesses[2] == 0 || guesses[2] == 1, "Invalid input");

        bets[msg.sender] = guesses;

        uint256 requestId = vrfRequestor.requestRandomWords(false);
        require(requestId > 0, "VRF request failed");
        playerRequestID[msg.sender] = requestId;
    }

    /// @notice Check if VRF request has been fulfilled.
    function checkStatus() external view returns (bool) {
        uint256 requestId = playerRequestID[msg.sender];
        require(requestId != 0, "No request found");

        ( , bool fulfilled, ) = vrfRequestor.getRequestStatus(requestId);
        return fulfilled;
    }

    /// @notice Determine if the user has won.
    function determineFlip() external view returns (bool) {
        uint256 requestId = playerRequestID[msg.sender];
        require(requestId != 0, "No request found");

        ( , bool fulfilled, uint256[] memory randomWords) = vrfRequestor.getRequestStatus(requestId);
        require(fulfilled, "Randomness not fulfilled yet");
        require(randomWords.length >= 3, "Not enough random numbers returned");

        uint8[3] memory guesses = bets[msg.sender];

        bool win = true;
        for (uint8 i = 0; i < 3; i++) {
            uint8 flipResult = uint8(randomWords[i] % 2);
            if (flipResult != guesses[i]) {
                win = false;
                break;
            }
        }
        return win;
    }
}
