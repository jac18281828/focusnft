# NFT Smart Contract Simple Working Example

* Foundry 
* Docker


### Deploy the smart contract 


1. `forge create --contracts contracts/focusnft.sol --rpc-url ${DEVNET_RPC} --private-key ${DEVNET_WALLET} --etherscan-api-key ${ETHERSCAN_API_KEY} --verify FocusNFT --constructor-args 'https://ipfs.io/ipfs/QmbPRkfUxB5mA2JXr5ZUWxLzpvEGT5qoRGe8z7GPicokXc'`

```
Compiling 19 files with 0.8.15
Solc 0.8.15 finished in 2.63s
Compiler run successful
Deployer: 0x6CEb0bF1f28ca4165d5C0A04f61DC733987eD6ad
Deployed to: 0xdCB27C0bF715f6F5D3a91Fd19C872778687eFA56
Transaction hash: 0x7ad24f5ac4955d02f36158f7410903871504f179d3018dab441568fe0d74816f
Starting contract verification...
Waiting for etherscan to detect contract deployment...

Submitting verification for [contracts/focusnft.sol:FocusNFT] Ok("0xdCB27C0bF715f6F5D3a91Fd19C872778687eFA56").

Submitting verification for [contracts/focusnft.sol:FocusNFT] Ok("0xdCB27C0bF715f6F5D3a91Fd19C872778687eFA56").

Submitting verification for [contracts/focusnft.sol:FocusNFT] Ok("0xdCB27C0bF715f6F5D3a91Fd19C872778687eFA56").

Submitting verification for [contracts/focusnft.sol:FocusNFT] Ok("0xdCB27C0bF715f6F5D3a91Fd19C872778687eFA56").
Submitted contract for verification:
	Response: `OK`
	GUID: `mespmivbblbxrqivihpzpnpabrj9ia1km6egtqinzjavqgfl8b`
	URL:
        https://goerli.etherscan.io/address/0xdcb27c0bf715f6f5d3a91fd19c872778687efa56

Waiting for verification result...

Contract successfully verified
```
