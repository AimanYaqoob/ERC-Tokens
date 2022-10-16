// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


// IPFS ----Inter Planetry File System------


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract AimanYaqoob is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 public mintRate = 0.01 ether;
    uint256 public Max_Supply=1;

    constructor() ERC721("aiman yaqoob", "AY") {}

    function safeMint(address to) public payable {
        require(totalSupply() < Max_Supply , "Can't mint more...");
        require(msg.value >= mintRate , "Not enough ethers sent!");
        _tokenIdCounter.increment();
        _safeMint(to,  _tokenIdCounter.current());
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function withDraw() public onlyOwner {
        require(address(this).balance > 0, "Balance is 0");
        payable (owner()).transfer(address(this).balance);
    }
}
