// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

import "forge-std/Test.sol";

import "../contracts/focusnft.sol";
import "@openzeppelin/contracts/interfaces/IERC721Receiver.sol";

contract FocusNftTests is Test {
    using stdStorage for StdStorage;

    FocusNFT private nft;

    function setUp() public {
        // Deploy NFT contract
        nft = new FocusNFT(
            "https://ipfs.io/ipfs/QmbPRkfUxB5mA2JXr5ZUWxLzpvEGT5qoRGe8z7GPicokXc"
        );
    }

    function testToAddress() public {
        uint256 tokenId = nft.mintToken(address(1));
        assertEq(tokenId, 1);
        vm.prank(address(1));
        assertEq(nft.ownerOf(tokenId), address(1), "token 1 owned by 1");
    }

    function testFailMintMaxTotalSupply() public {
        uint256 slot = stdstore
            .target(address(nft))
            .sig("currentTokenId()")
            .find();
        bytes32 loc = bytes32(slot);
        bytes32 mockedCurrentTokenId = bytes32(abi.encode(10000));
        vm.store(address(nft), loc, mockedCurrentTokenId);
        nft.mintToken(address(1));
    }

    function testSafeContractReceiver() public {
        Receiver receiver = new Receiver();
        nft.mintToken(address(receiver));
        uint256 slotBalance = stdstore
            .target(address(nft))
            .sig(nft.balanceOf.selector)
            .with_key(address(receiver))
            .find();

        uint256 balance = uint256(vm.load(address(nft), bytes32(slotBalance)));
        assertEq(balance, 1);
    }

    function testFailUnSafeContractReceiver() public {
        vm.etch(address(1), bytes("mock code"));
        nft.mintToken(address(1));
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
}

contract Receiver is IERC721Receiver {
    function onERC721Received(
        address, /* operator */
        address, /* from */
        uint256, /* id */
        bytes calldata /* data */
    ) external pure returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
