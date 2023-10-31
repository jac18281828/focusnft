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

import { Script } from "forge-std/Script.sol";

import { FocusNFT } from "../contracts/FocusNFT.sol";

contract DeployNFT is Script {
    event NFTDeployed(address contractAddress);
    event TokenMint(address contractAddress, uint256 tokenId);

    string private constant META_URL = "https://ipfs.io/ipfs/QmbPRkfUxB5mA2JXr5ZUWxLzpvEGT5qoRGe8z7GPicokXc";

    function storeCode() external {
        bytes memory createCode = abi.encodePacked(type(FocusNFT).creationCode, abi.encode(META_URL));
        vm.writeFile("./FocusNFT.bin", vm.toString(createCode));
    }

    function deploy() external {
        vm.startBroadcast();
        bytes32 vanitySalt = "focusnft";
        FocusNFT nftContract = new FocusNFT{ salt: vanitySalt }(META_URL);
        vm.stopBroadcast();
        emit NFTDeployed(address(nftContract));
    }

    function mint() external {
        address _nftAddr = vm.envAddress("NFT_CONTRACT");
        address _destWallet = vm.envAddress("RECIPIENT");
        uint256 mintCount = vm.envUint("MINT_COUNT");
        FocusNFT nftContract = FocusNFT(_nftAddr);
        vm.startBroadcast();
        for (uint256 i = 0; i < mintCount; ++i) {
            uint256 tokenId = nftContract.mintToken(_destWallet);
            emit TokenMint(address(nftContract), tokenId);
        }
        vm.stopBroadcast();
    }
}
