// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    struct TokenMetaData {
        string name;
        string description;
        string imageUri;
    }

    mapping(uint256 => TokenMetaData) private _tokenMetaData;
    uint256 private _tokenIdCounter;

    constructor() ERC721("MyNFT", "MNFT") {
        _tokenIdCounter = 1;
    }

    // ["DemoOne", "DemoOneDesc", " bafybeibduej4ehrvpufjtylh3dy2bzsfqvvhmfp4hrpxcwfusu7j25plxm"]
    function setTokenMetadata(
        uint256 tokenID,
        TokenMetaData memory metadata
    ) private {
        _tokenMetaData[tokenID] = metadata;
    }

    // Return as tuple
    function getTokenMetaData(
        uint256 tokenID
    ) external view returns (TokenMetaData memory) {
        return _tokenMetaData[tokenID];
    }

    // Deconstructs the TokenMetaData struct and returns individual components: name, description, and imageUri as a tuple of string values.
    // function getTokenMetaData(
    //     uint256 _tokenID
    // )
    //     public
    //     view
    //     returns (
    //         string memory name,
    //         string memory description,
    //         string memory imageUri
    //     )
    // {
    //     require(_tokenID < _tokenIdCounter, "Invalid token id");
    //     TokenMetaData memory t = _tokenMetaData[_tokenID];
    //     return (t.name, t.description, t.imageUri);
    // }

    function createToken(TokenMetaData memory metadata) external {
        uint256 newTokenId = _tokenIdCounter;
        _tokenIdCounter++;

        _mint(msg.sender, newTokenId);
        setTokenMetadata(newTokenId, metadata);
    }
}
