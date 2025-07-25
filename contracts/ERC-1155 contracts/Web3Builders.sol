// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.27;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155Pausable} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import {ERC1155Supply} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Web3Builders is ERC1155, Ownable, ERC1155Pausable, ERC1155Supply {
    constructor(address initialOwner)
        ERC1155("ipfs://Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3Hye/")
        Ownable(initialOwner)
    {}

    

    uint256 public  publicPrice= 0.02 ether;    
    uint256 public publicAllowListPrice= 0.01 ether;
    uint256 public  maxSupply=3;

    bool allowListMintOpen;
    bool publicMintOpen;

    // Setting the allowList mapping
    mapping (address => bool) allowList;



//    modifier  onlyOwner(address account){
//     require(msg.sender ==account,"You are not  the owner");
//     _;

//    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function uri(uint256 _id) public view virtual override  returns (string memory) {
        require(exists(_id),"URI does not exist");
        return string(abi.encodePacked(super.uri(_id),Strings.toString(_id),".json"));
    }



    function pause() public onlyOwner {
        _pause();
    }


    function unpause() public onlyOwner {
        _unpause();
    }


    function edit(
        bool _allowListMintOpen,
        bool _publicMintOpen
    ) external onlyOwner{
        allowListMintOpen=_allowListMintOpen;
        publicMintOpen=_publicMintOpen;

    }

    function setAllowList(address[] calldata addresses) external  onlyOwner{
        for(uint256 i;i <addresses.length;i++){
            allowList[addresses[i]] = true;
        }
    }


    function allowListMint(uint256 id,uint256 amount) public  payable {

        require(allowListMintOpen,"Sorry! AllowList mint is not open");
        require(allowList[msg.sender],"Sorry! You are not allowed to mint. Try public mint");
                require(id < 2,"You are trying to mint the wrong NFT.");

                require(totalSupply(id) * amount < maxSupply,"No remaining NFTs");
                require(msg.value == publicAllowListPrice * amount,"Insufficient balance");
                _mint(msg.sender, id, amount, "");
    }


    function mint(uint256 id, uint256 amount)
        public
        payable 
        
    {
        require(publicMintOpen,"Sorry! publix mint is not open");
        require(id < 2,"You are trying to mint the wrong NFT.");
        require(totalSupply(id)* amount < maxSupply,"No remaining NFTs");
        require(msg.value == publicPrice * amount,"Insufficient balance");
        _mint(msg.sender, id, amount,"");
    }

    // Withdrawng
    function withdraw(address _addr) external  onlyOwner{
        uint256 balance= address(this).balance;
        payable(_addr).transfer(balance);
    }


    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Pausable, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }
}
