// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    uint256 private tokenCounter;

    struct NFTForSale {
        uint256 tokenId;
        address seller;
        uint256 price;
    }

    struct NFTUnique {
        string shortMessage;
        string nickname;
    }

    struct TokenMetaData {
        string name;
        string description;
        string imageUri;
        string nickname;
    }

    mapping(uint256 => TokenMetaData) private _tokenMetaData;
    mapping(uint256 => NFTForSale) public nftForSale;
    uint256[] private tokenForSale;

    constructor() ERC721("MyNFT", "MNFT") {
        tokenCounter = 1;
    }

    // ["First NFT", "NFT Desc", "This is image uri", "", ""]
    function createNFT(
        address recipient,
        string memory name,
        string memory desc,
        string memory imageURI
    ) external {
        uint256 newTokenId = tokenCounter;
        tokenCounter++;

        // Set token metadata without nickname
        _tokenMetaData[newTokenId] = TokenMetaData({
            name: name,
            description: desc,
            imageUri: imageURI,
            nickname: ""
        });

        _safeMint(recipient, newTokenId);
    }

    function getTokenMetaData(
        uint256 _tokenID
    )
        external
        view
        returns (
            string memory name,
            string memory description,
            string memory imageUri,
            string memory nickname
        )
    {
        require(_tokenID < tokenCounter, "Invalid token id");
        TokenMetaData memory t = _tokenMetaData[_tokenID];
        return (t.name, t.description, t.imageUri, t.nickname);
    }

    function listForSale(uint256 tokenID, uint256 price) external {
        require(ownerOf(tokenID) == msg.sender, "Not the owner of token");
        require(price > 0, "Price must be greater than zero");

        nftForSale[tokenID] = NFTForSale(tokenID, msg.sender, price);
        tokenForSale.push(tokenID);

        _transfer(msg.sender, address(this), tokenID);
    }

    function getAllTokensForSale() external view returns (NFTForSale[] memory) {
        uint256 arrayLength = tokenForSale.length;
        NFTForSale[] memory allSales = new NFTForSale[](arrayLength);

        for (uint256 i; i < arrayLength; i++) {
            // you cannot use push for a fixed-length memory array
            allSales[i] = nftForSale[tokenForSale[i]];
        }

        return allSales;
    }

    function _removeTokenFromSale(uint256 tokenID) private {
        delete nftForSale[tokenID];
        uint256 arrayLength = tokenForSale.length;

        for (uint256 i; i < arrayLength; i++) {
            if (tokenForSale[i] == tokenID) {
                tokenForSale[i] = tokenForSale[arrayLength - 1];
                tokenForSale.pop();
                break;
            }
        }
    }

    function buy(uint256 tokenID, string memory nickname) external payable {
        require(bytes(nickname).length > 0, "Nickname cannot be empty");

        NFTForSale memory selectedSale = nftForSale[tokenID];

        require(selectedSale.price > 0, "NFT is not for sale");
        require(
            msg.value == selectedSale.price,
            "Value sent must match sale price"
        );

        // Append nickname metadata to the nft
        _tokenMetaData[tokenID].nickname = nickname;

        _removeTokenFromSale(tokenID);

        payable(selectedSale.seller).transfer(msg.value);

        _transfer(address(this), msg.sender, tokenID);
    }

    function totalSupply() public view returns (uint256) {
        return tokenCounter;
    }
}
