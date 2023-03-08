// SPDX-License-Identifier: MIT
pragma solidity >0.7 <0.9;

import "./MyERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IMyToken is IERC20 {
    function mint(address to, uint256 amount) external;
    function burnFrom(address account, uint256 amount) external;
}

contract TokenSale  {
    uint256 public ratio;
    uint256 public price;
    IMyToken public tokenAddress;

    constructor(uint256 _ratio, uint256 _price, address _tokenAddress ) {
        ratio = _ratio;
        price = _price;
        tokenAddress = IMyToken(_tokenAddress);
    }

    function buyTokens() external payable {
        // how many tokens are minted is depended on the amount a person 
        // is paying (value) and on the ratio 
        tokenAddress.mint(msg.sender, msg.value * ratio);
    }

    function burnTokens(uint256 amount) external {
        // should burn the correct amount of tokens
        tokenAddress.burnFrom(msg.sender, amount);

        // Give ETH back to the user
        payable(msg.sender).transfer(amount / ratio);
    }

    function buyNFT(uint256 tokenId) external {
        // charge the payment
        tokenAddress.transferFrom(msg.sender, address(this), price);
        // Mint the NFT 
        // Account the amount that the owner can withdraw
    }
}