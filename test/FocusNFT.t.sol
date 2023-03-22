// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

import "forge-std/Test.sol";

import "../contracts/FocusNFT.sol";
import "@openzeppelin/contracts/interfaces/IERC721Receiver.sol";

contract FocusNftTests is Test {
    using stdStorage for StdStorage;

    string private constant META_URL = "https://ipfs.io/ipfs/QmbPRkfUxB5mA2JXr5ZUWxLzpvEGT5qoRGe8z7GPicokXc";

    FocusNFT private nft;

    function setUp() public {
        // Deploy NFT contract
        nft = new FocusNFT(META_URL);
    }

    function testToAddress() public {
        uint256 tokenId = nft.mintToken(address(0x1));
        assertEq(tokenId, 1);
        vm.prank(address(0x1));
        assertEq(nft.ownerOf(tokenId), address(0x1), "token 1 owned by 1");
    }

    function testTransferFrom() public {
        uint256 tokenId = nft.mintToken(address(0x1));
        vm.prank(address(0x1));
        nft.transferFrom(address(0x1), address(2), tokenId);
        assertEq(nft.ownerOf(tokenId), address(2), "token 1 owned by 1");
    }

    function testSafeTransfer() public {
        uint256 tokenId = nft.mintToken(address(0x1));
        vm.prank(address(0x1));
        nft.safeTransferFrom(address(0x1), address(2), tokenId);
        assertEq(nft.ownerOf(tokenId), address(2), "token 1 owned by 1");
    }

    function testSafeTransferData() public {
        uint256 tokenId = nft.mintToken(address(0x1));
        vm.prank(address(0x1));
        nft.safeTransferFrom(address(0x1), address(2), tokenId, bytes(""));
        assertEq(nft.ownerOf(tokenId), address(2), "token 1 owned by 1");
    }

    function testTotalSupply() public {
        nft.mintToken(address(0x1));
        assertEq(nft.totalSupply(), 1);
    }

    function testTokenByIndex() public {
        uint256 tokenId1 = nft.mintToken(address(0x1));
        uint256 tokenId2 = nft.mintToken(address(2));
        assertEq(nft.tokenByIndex(0), tokenId1);
        assertEq(nft.tokenByIndex(1), tokenId2);
    }

    function testTokenOfOwnerByIndex() public {
        uint256 tokenId10 = nft.mintToken(address(0x1));
        uint256 tokenId20 = nft.mintToken(address(2));
        uint256 tokenId11 = nft.mintToken(address(0x1));
        assertEq(nft.tokenOfOwnerByIndex(address(0x1), 0), tokenId10);
        assertEq(nft.tokenOfOwnerByIndex(address(0x1), 1), tokenId11);
        assertEq(nft.tokenOfOwnerByIndex(address(2), 0), tokenId20);
    }

    function testTransferFromOwnerByIndex() public {
        uint256 tokenId = nft.mintToken(address(0x1));
        vm.prank(address(0x1));
        nft.transferFrom(address(0x1), address(2), tokenId);
        assertEq(nft.tokenByIndex(0), tokenId);
        assertEq(nft.totalSupply(), 1);
        assertEq(nft.balanceOf(address(0x1)), 0);
        assertEq(nft.balanceOf(address(2)), 1);
        assertEq(nft.tokenOfOwnerByIndex(address(2), 0), tokenId);
    }

    function testFailTransferFromNoLongerOwnerByIndex() public {
        uint256 tokenId = nft.mintToken(address(0x1));
        vm.prank(address(0x1));
        nft.transferFrom(address(0x1), address(2), tokenId);
        assertEq(nft.tokenByIndex(0), tokenId);
        nft.tokenOfOwnerByIndex(address(0x1), 0);
    }

    function testFailTokenOfOwnerByIndexNotOwner() public {
        nft.mintToken(address(0x1));
        nft.tokenOfOwnerByIndex(address(2), 0);
    }

    function testFailTokenOfOwnerByInvalidIndex() public {
        nft.mintToken(address(0x1));
        nft.tokenOfOwnerByIndex(address(0x1), 1);
    }

    function testFailMintMaxTotalSupply() public {
        uint256 slot = stdstore.target(address(nft)).sig("currentTokenId()").find();
        bytes32 loc = bytes32(slot);
        bytes32 mockedCurrentTokenId = bytes32(abi.encode(10000));
        vm.store(address(nft), loc, mockedCurrentTokenId);
        nft.mintToken(address(0x1));
    }

    function testSafeContractReceiver() public {
        Receiver receiver = new Receiver();
        nft.mintToken(address(receiver));
        uint256 slotBalance = stdstore.target(address(nft)).sig(nft.balanceOf.selector).with_key(address(receiver)).find();

        uint256 balance = uint256(vm.load(address(nft), bytes32(slotBalance)));
        assertEq(balance, 1);
    }

    function testFailUnSafeContractReceiver() public {
        vm.etch(address(0x1), bytes("mock code"));
        nft.mintToken(address(0x1));
    }

    function testSupportsERC721() public {
        bytes4 esId = type(IERC721).interfaceId;
        assertTrue(nft.supportsInterface(esId));
    }

    function testSupportsERC721Enumerable() public {
        bytes4 esId = type(IERC721Enumerable).interfaceId;
        assertTrue(nft.supportsInterface(esId));
    }

    function testSupportsERC165() public {
        bytes4 esId = type(ERC165).interfaceId;
        assertTrue(nft.supportsInterface(esId));
    }

    function testMintRequiresOwner() public {
        vm.prank(address(0x1));
        vm.expectRevert("Ownable: caller is not the owner");
        nft.mintToken(address(0x1));
    }
}

contract Receiver is IERC721Receiver {
    function onERC721Received(
        address /* operator */,
        address /* from */,
        uint256 /* id */,
        bytes calldata /* data */
    ) external pure returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
