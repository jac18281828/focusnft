// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.20;

import { IERC721Receiver } from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

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
