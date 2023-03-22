# NFT Smart Contract Simple Working Example

- Foundry
- Docker

### Deploy the smart contract

#### 0.2.0 Deployment Address

Deployer: 0x6CEb0bF1f28ca4165d5C0A04f61DC733987eD6ad
Deployed to: 0xfF8967a1d1936C9659697B38eE256F34eC6bc756
Transaction hash: 0xe82a3c9edf283cea35e2ae54229b8e24fa6d6b7258304a77d9d12448a7edbad4

[Etherscan.io](https://goerli.etherscan.io/address/0xff8967a1d1936c9659697b38ee256f34ec6bc756)

1. `forge create --contracts contracts/FocusNFT.sol --rpc-url ${DEVNET_RPC} --private-key ${DEVNET_WALLET} --etherscan-api-key ${ETHERSCAN_API_KEY} --verify FocusNFT --constructor-args 'https://ipfs.io/ipfs/QmbPRkfUxB5mA2JXr5ZUWxLzpvEGT5qoRGe8z7GPicokXc'`

### 0.2.1

```
Compiling 21 files with 0.8.15
Solc 0.8.15 finished in 3.51s
Compiler run successful
Deployer: 0x6CEb0bF1f28ca4165d5C0A04f61DC733987eD6ad
Deployed to: 0xE3C82840FA0605a424Cc1ea6BC013D12909E4e69
Transaction hash: 0xc76aa13b2133faaf18f6885b09ea137dca8595d8bfde44db673ce9502ba780d4
Starting contract verification...
Waiting for etherscan to detect contract deployment...
Submitting verification for [contracts/FocusNFT.sol:FocusNFT] "0xE3C82840FA0605a424Cc1ea6BC013D12909E4e69".
Submitting verification for [contracts/FocusNFT.sol:FocusNFT] "0xE3C82840FA0605a424Cc1ea6BC013D12909E4e69".
Submitting verification for [contracts/FocusNFT.sol:FocusNFT] "0xE3C82840FA0605a424Cc1ea6BC013D12909E4e69".
Submitting verification for [contracts/FocusNFT.sol:FocusNFT] "0xE3C82840FA0605a424Cc1ea6BC013D12909E4e69".
Submitting verification for [contracts/FocusNFT.sol:FocusNFT] "0xE3C82840FA0605a424Cc1ea6BC013D12909E4e69".
Submitting verification for [contracts/FocusNFT.sol:FocusNFT] "0xE3C82840FA0605a424Cc1ea6BC013D12909E4e69".
Submitted contract for verification:
	Response: `OK`
	GUID: `t9vv9nchkmyegvpkpeiypev8vnnat2w7ryfxnesy3ilebhhiqw`
	URL:
        https://goerli.etherscan.io/address/0xe3c82840fa0605a424cc1ea6bc013d12909e4e69
Waiting for verification result...
Contract successfully verified
```
