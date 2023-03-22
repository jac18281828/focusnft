# NFT Smart Contract Simple Working Example

- Foundry
- Docker

### Deploy the smart contract


#### 0.4.0 Deployment Address on Sepolia Testnet

```
ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
Total Paid: 0.038220831098114943 ETH (12740277 gas * avg 3.000000007 gwei)
##
Start verification for (1) contracts
Start verifying contract `0x8d9e6804afafbbe38a853f533567e0da3f116ed5` deployed on sepolia

Submitting verification for [contracts/FocusNFT.sol:FocusNFT] "0x8D9e6804AFAFBbe38a853f533567e0DA3F116Ed5".
Submitted contract for verification:
        Response: `OK`
        GUID: `gmz1yflapypardmxsz2n1tgkz9uwvqcpijdwkyhcbldfmdfj9g`
        URL:
        https://sepolia.etherscan.io/address/0x8d9e6804afafbbe38a853f533567e0da3f116ed5
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
All (1) contracts were verified!

```


### 

1. `forge create --contracts contracts/FocusNFT.sol --rpc-url ${DEVNET_RPC} --private-key ${DEVNET_WALLET} --etherscan-api-key ${ETHERSCAN_API_KEY} --verify FocusNFT --constructor-args 'https://ipfs.io/ipfs/QmbPRkfUxB5mA2JXr5ZUWxLzpvEGT5qoRGe8z7GPicokXc'`

### 0.2.1 on Görli

```
COMPILING 21 files with 0.8.15
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
