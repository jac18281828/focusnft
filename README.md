# NFT Smart Contract Simple Working Example

- Foundry
- Docker

### Deploy the smart contract

How to deploy with a vanity address. Undocumented foundry feature.

```
    address public constant DEPLOYER_ADDRESS = 0x4e59b44847b379578588920cA78FbF26c0B4956C;
```

1. save the contract code by running task `storecode`
2. generate the vanity address `yarn vanity`
3. convert the salt to hex
   ```
   cast --to-base 42251974336832307529671168963487630945990082533759568101302140718446315516530 16
   0x5d69c51ee37ee115e2e32db32c98241bd7e6db5a9dbd9d2c6d2051cb0b133272
   ```
4. add hex salt to deployment script
5. task `deploynft`

```
FocusNFT nftContract = new FocusNFT{salt: vanitysalt}(_nftAddr);
```

#### 0.4.0 Deployment Address on Sepolia Testnet

```
ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
Total Paid: 0.00426947401423158 ETH (1423158 gas * avg 3.00000001 gwei)
##
Start verification for (1) contracts
Start verifying contract `0x0C7318c65A1c1028A6bD01c7108cA064B3a4A301` deployed on sepolia

Submitting verification for [contracts/FocusNFT.sol:FocusNFT] "0x0C7318c65A1c1028A6bD01c7108cA064B3a4A301".
Submitted contract for verification:
        Response: `OK`
        GUID: `ikj1eruhkejlqciuudmexbhwqrzacsnyudwnus1jtrpn4samg9`
        URL:
        https://sepolia.etherscan.io/address/0x0c7318c65a1c1028a6bd01c7108ca064b3a4a301
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
