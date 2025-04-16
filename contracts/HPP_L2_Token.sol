// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Bridgeable} from "@openzeppelin/community-contracts/contracts/token/ERC20/extensions/ERC20Bridgeable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract HousePartyProtocol is ERC20, ERC20Bridgeable, ERC20Permit {
    address internal constant SUPERCHAIN_TOKEN_BRIDGE = 0x4200000000000000000000000000000000000028;
    error Unauthorized();

    constructor()
        ERC20("HousePartyProtocol", "HPP")
        ERC20Permit("HousePartyProtocol")
    {}

    /**
     * @dev Checks if the caller is the predeployed SuperchainTokenBridge. Reverts otherwise.
     *
     * IMPORTANT: The predeployed SuperchainTokenBridge is only available on chains in the Superchain.
     */
    function _checkTokenBridge(address caller) internal pure override {
        if (caller != SUPERCHAIN_TOKEN_BRIDGE) revert Unauthorized();
    }
}
