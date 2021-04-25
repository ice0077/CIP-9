// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

interface IERC721Mint {
    function mint(address to, string memory tokenURI) external returns(uint256 tokenId);

    function burn(uint256 tokenId) external;

    event MintEvent(address operator, address to, string tokenURI, uint256 tokenId);
}