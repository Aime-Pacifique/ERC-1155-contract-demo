// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.27;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {ERC721Pausable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";



contract Web3Builders is ERC721, ERC721Enumerable, ERC721URIStorage, ERC721Pausable, Ownable {
    uint256 private _nextTokenId;
    uint256 public  maxSupply= 1;
    bool private  allowListMintOpen= false;
    bool private  publicMintOpen=false;
    mapping (address => bool) allowList;
    

    constructor(address initialOwner)
        ERC721("Web3Builders", "WE3")
        Ownable(initialOwner)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmY5rPqGTN1rZxMQg2ApiSZc7JiBNs1ryDzXPZpQhC1ibm/";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }


    // Widthdrawing funds

function withdraw( address _addr) external  onlyOwner{

uint256 balance= address(this).balance;
payable (_addr).transfer(balance);
}


// Modify Mint Windows
function editMintWindows(bool _allowListMintOpen,bool _publicMintOpen) external onlyOwner{

   allowListMintOpen= _allowListMintOpen;
   publicMintOpen= _publicMintOpen;
}


// Added mint windws
    function allowListMint()
        public
        payable 
        returns (uint256)
    {
        require(allowList[msg.sender],"You are not included in allow list");
        require(allowListMintOpen,"AllowList Mint closed");
       require(msg.value == 0.001 ether,"Not enough funds");
       require(totalSupply() < maxSupply,"NO more supply allowed");
        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
        // _setTokenURI(tokenId, uri);
        return tokenId;
    }
    function publicMInt()
        public
        payable 
        returns (uint256)
    {
        require(publicMintOpen,"Public Mint closed");
       require(msg.value == 0.01 ether,"Not enough funds");
       require(totalSupply() < maxSupply,"NO more supply allowed");
        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
        // _setTokenURI(tokenId, uri);
        return tokenId;
    }

    function setAllowList(address[] calldata addresses) public  onlyOwner{
        for (uint256 i=0;i <  addresses.length;i++){
            allowList[addresses[i]]= true;
        }

    }

    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable, ERC721Pausable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}