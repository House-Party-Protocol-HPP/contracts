// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
 
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import {ERC165} from "@openzeppelin/contracts/interfaces/IERC165.sol";
//import {IERC7802} from "@openzeppelin/contracts/token/ERC20/IERC7802.sol";
//import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
//contract L2HousePartyProtocol is ERC20, Ownable, IERC7802 {

interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[ERC section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

interface IERC7802 is IERC165 {
    /// @notice Emitted when a crosschain transfer mints tokens.
    /// @param to       Address of the account tokens are being minted for.
    /// @param amount   Amount of tokens minted.
    /// @param sender   Address of the account that finilized the crosschain transfer.
    event CrosschainMint(address indexed to, uint256 amount, address indexed sender);

    /// @notice Emitted when a crosschain transfer burns tokens.
    /// @param from     Address of the account tokens are being burned from.
    /// @param amount   Amount of tokens burned.
    /// @param sender   Address of the account that initiated the crosschain transfer.
    event CrosschainBurn(address indexed from, uint256 amount, address indexed sender);

    /// @notice Mint tokens through a crosschain transfer.
    /// @param _to     Address to mint tokens to.
    /// @param _amount Amount of tokens to mint.
    function crosschainMint(address _to, uint256 _amount) external;

    /// @notice Burn tokens through a crosschain transfer.
    /// @param _from   Address to burn tokens from.
    /// @param _amount Amount of tokens to burn.
    function crosschainBurn(address _from, uint256 _amount) external;
}

contract L2HousePartyProtocol is ERC20, IERC7802 {

    error NotSuperchainERC20Bridge();
 
//    constructor(address owner, string memory name, string memory symbol) ERC20(name, symbol) Ownable(owner) {}
//    function mint(address to, uint256 amount) public onlyOwner {
//        _mint(to, amount);
//    }
 
    /// @notice Allows the SuperchainTokenBridge to mint tokens.
    /// @param _to Address to mint tokens to.
    /// @param _amount Amount of tokens to mint.
    function crosschainMint(address _to, uint256 _amount) external {
        if (msg.sender != 0x4200000000000000000000000000000000000028) revert NotSuperchainERC20Bridge();
 
        _mint(_to, _amount);
 
       emit CrosschainMint(_to, _amount, msg.sender);
    }
 
    /// @notice Allows the SuperchainTokenBridge to burn tokens.
    /// @param _from Address to burn tokens from.
    /// @param _amount Amount of tokens to burn.
    function crosschainBurn(address _from, uint256 _amount) external {
        if (msg.sender != 0x4200000000000000000000000000000000000028) revert NotSuperchainERC20Bridge();
        
        _burn(_from, _amount);
 
      emit  CrosschainBurn(_from, _amount, msg.sender);
    }
 
//    function supportsInterface(bytes4 _interfaceId) public view virtual returns (bool) {
//      
//      return true ;
//    }

    function supportsInterface(bytes4 _interfaceId) public view virtual returns (bool) {
        return _interfaceId == type(IERC7802).interfaceId || 
               _interfaceId == type(ERC20).interfaceId 
               || _interfaceId == type(IERC165).interfaceId;
//               || _interfaceId == type(ERC165).interfaceId;
    }

    constructor()
        ERC20("HousePartyProtocol", "HPP")
//        ERC20Permit("HousePartyProtocol")
    { }
}
