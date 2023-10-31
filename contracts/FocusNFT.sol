// SPDX-License-Identifier: BSD-3-Clause
/*
 * Copyright 2022,2023 John Cairns
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
pragma solidity 0.8.20;

import { ERC721, IERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { IERC165 } from "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import { IERC721Enumerable } from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract FocusNFT is ERC721, IERC721Enumerable, Ownable {
    error InvalidRecipient();
    error InvalidToken();
    error TokenSupplyExhausted();
    error TokenDoesNotExist();
    error InvalidTokenIndex();
    error TokenNotFoundInOwnerSupply();

    event FocusTokenMint(uint256 id, address recipient);

    uint256 public constant MAX_SUPPLY = 10000;

    string public _baseUri;
    uint256 private _currentTokenId = 0;

    mapping(uint256 => uint256) private _tokenSupplyIndex;
    mapping(address => OwnerSupply) private _ownerSupply;

    struct OwnerSupply {
        uint256 _totalCount;
        // index to tokenId
        mapping(uint256 => uint256) _supply;
    }

    constructor(string memory __baseUri, address _owner) ERC721("Focus", "FCUS") Ownable(_owner) {
        _baseUri = __baseUri;
    }

    modifier requireValidRecipient(address _recipient) {
        if (_recipient == address(0)) revert InvalidRecipient();
        _;
    }

    modifier requireValidTokenId(uint256 _tokenId) {
        if (_tokenId == 0) revert InvalidToken();
        _;
    }

    function mintToken(address _recipient) public payable onlyOwner requireValidRecipient(_recipient) returns (uint256) {
        if (_currentTokenId >= MAX_SUPPLY) revert TokenSupplyExhausted();
        uint256 tokenIndex = _currentTokenId++;
        uint256 tokenId = _currentTokenId;
        _safeMint(_recipient, tokenId);
        _tokenSupplyIndex[tokenIndex] = tokenId;
        addOwnerSupply(_recipient, tokenId);
        emit FocusTokenMint(tokenId, _recipient);
        return tokenId;
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public virtual override(ERC721, IERC721) {
        super.transferFrom(_from, _to, _tokenId);
        removeOwnerSupply(_from, _tokenId);
        addOwnerSupply(_to, _tokenId);
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) revert TokenDoesNotExist();
        return bytes(_baseUri).length > 0 ? _baseUri : "";
    }

    function totalSupply() external view returns (uint256) {
        return _currentTokenId;
    }

    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256) {
        OwnerSupply storage ownerSupply = _ownerSupply[_owner];
        if (_index >= ownerSupply._totalCount) revert InvalidTokenIndex();
        return ownerSupply._supply[_index];
    }

    function tokenByIndex(uint256 _index) public view returns (uint256) {
        if (_index >= _currentTokenId) revert InvalidTokenIndex();
        return _tokenSupplyIndex[_index];
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(IERC165, ERC721) returns (bool) {
        return interfaceId == type(IERC721Enumerable).interfaceId || super.supportsInterface(interfaceId);
    }

    function addOwnerSupply(address _recipient, uint256 _tokenId) private {
        if (_recipient != address(0)) {
            OwnerSupply storage ownerSupply = _ownerSupply[_recipient];
            uint256 ownerIndex = ownerSupply._totalCount++;
            ownerSupply._supply[ownerIndex] = _tokenId;
        }
    }

    function removeOwnerSupply(address _wallet, uint256 _tokenId) private requireValidTokenId(_tokenId) {
        if (_wallet != address(0)) {
            OwnerSupply storage ownerSupply = _ownerSupply[_wallet];
            for (uint256 i = 0; i < ownerSupply._totalCount; i++) {
                if (_tokenId == ownerSupply._supply[i]) {
                    for (uint256 j = i; j < ownerSupply._totalCount; j++) {
                        // re-map each member of the range
                        ownerSupply._supply[j] = ownerSupply._supply[j + 1];
                    }
                    ownerSupply._totalCount--;
                    ownerSupply._supply[ownerSupply._totalCount] = 0;
                    return;
                }
            }
            revert TokenNotFoundInOwnerSupply();
        }
    }
}
