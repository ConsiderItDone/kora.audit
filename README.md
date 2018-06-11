# Kora Network Token Audit

## Summary

[Kora](https://kora.network/) has launched a Token Sale in May 2018. Kora's WhitePaper can be found [here](https://kora.network/#whitepaper).

[Consider It Done Technologies, LLC](https://consideritdone.tech/) was commissioned to perform an audit on the Ethereum smart contracts for Kora's token contract.

The audited contract with included code review can be found in the [contracts](/contracts/) directory.

No vulnerabilities have been identified in the token contract.

There are some major warnings were concluded during the token contract audit.


## Audit details

### Invalid token supply

`Kora Network Token` declares `0.00000007125` supply instead of `712500000.0`.

### No Token Sale contract
There is no Token Sale contract was found, the Token contract only.
If Token Sale implemented via centralized system, it can include operational/human factor risks and can be the cause of the tokens theft or any other unexpected behavior due to human intervention by computer system managers, hackers, etc.
Product owner and all the customers should trust the managers of the centralized system and ensure that used centralized system is protected from intervention by hackers.

### `Copy-paste` approach was used instead of `npm` module usage
The code uses [OpenZeppelin, a framework to build secure smart contracts on Ethereum](https://github.com/OpenZeppelin/openzeppelin-solidity) version 1.9.0, that is a good code practice.
Nevertheless, there was found no package that uses OpenZeppelin library from the original `npm` repository; `copy-paste` approach was used instead of `npm` module usage.
Therefore, the copy-pasted code was additionally checked for the malicious modifications and original identity.

In the course of our analysis, the code identity was not confirmed. Differences was found in the `Ownable` contract. There is exist additional `renounceOwnership()` method. Details can be found [here](#TODO renounceOwnership link).

Original OpenZeppelin library code files version 1.9.0 can be found [here](TODO ./node_modules/openzeppelin-solidity/).

### `renounceOwnership()` method
There is `renounceOwnership()` was found in the `Ownable` contract.

If `owner` (wallet that deployed the contract) of the contract is a centralized system, it can cause critical problem by loss of ownership if `renounceOwnership()` is called.
If there is no need to lose control over the token contract, we strongly recommend to remove this method from the contract.

Nevertheless, `Ownable` contract is implemented, but not used in the token. Details are explained [here](#TODO link ownable).

### 16 decimals
Using 18 (`wei`) decimals is a more common practice.

Using 18 decimals:
* Reduces the user experience complexity of adding ERC20 tokens
* Allows ERC20 transfer transactions to be easily detected and have the correct value shown on wallets (including hardware wallets) without requiring pre-setup
* Ensures that in any on-chain exchange, the price as expressed in computer units (ie. wei or equivalent) is the same number as the price as expressed in human units (ie. ether or equivalent), reducing the risk of confusion or bugs

If 16 decimal is not a business requirement, it would be better to use 18 decimals instead.


### `Ownable` contract is implemented, but not used
OpenZeppelin `Ownable` contract allows to change the owner of the token contract.
This contract is copied from original OpenZeppelin library and modified with lose-control issue (details are [here](#TODO link ren)), but is not inherited by any contract in the code, including KNT token contract.
Contract owner cannot change ownership if `Ownable` contract is not inherited. If the owner's wallet is compromised, the hacker will get full control over the token contract.


## Conclusions
* Token contract code contains a lot of excess code due to copy-pastes of the OpenZeppelin library instead of library usage.
* There is no Token Sale contract.
* Token contract has some critical issues that should be fixed.
