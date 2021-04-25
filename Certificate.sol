// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./RoleControl.sol";
import "./IERC721Mint.sol";

contract Certificate is ERC721, Ownable, RoleControl, IERC721Mint {
    bytes32 private constant MINT_ADMIN_ROLE = keccak256("MINTER_ROLE");

    string private constant erc721Name = "College Certificate NFT";
    string private constant erc721Symbol = "CC-NFT";

    uint256 public tokenIdIndex;
    mapping(string => bool) tokenURIMap;


    constructor () public ERC721(erc721Name, erc721Symbol) { 

        _setupRole(MINT_ADMIN_ROLE, msg.sender);
    }

    modifier onlyMintAdmin() {
        require(isMintAdmin(msg.sender), "ShopNftContract: caller does not have the Admin role");
        _;
    }

    function isMintAdmin(address account) public view returns (bool) {
        return hasRole(MINT_ADMIN_ROLE, account);
    }

    function grantMintRole(address account) public onlyOwner {
        _setupRole(MINT_ADMIN_ROLE, account);
    }

    function revokeMintRole(address account) public onlyOwner {
        _removeRole(MINT_ADMIN_ROLE, account);
    }

    function mint(address to, string memory tokenURI) public override onlyMintAdmin returns(uint256 tokenId) {
        require(!tokenURIMap[tokenURI], "ShopNftContract error mint");

        tokenURIMap[tokenURI] = true;

        tokenIdIndex = tokenIdIndex + 1;
        _mint(to, tokenIdIndex);
        _setTokenURI(tokenIdIndex, tokenURI);

        emit MintEvent(msg.sender, to, tokenURI, tokenIdIndex);

        return tokenIdIndex;
    }

    function transferFrom(address from, address to, uint256 tokenId) public virtual override {
        
    }
    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override {

    }
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public virtual override {

    }

    function burn(uint256 tokenId) public override onlyMintAdmin {
        // // tokenId是否还存在
        // ownerOf(tokenId);

        // // 销毁
        // _burn(tokenId);
    }

 }

