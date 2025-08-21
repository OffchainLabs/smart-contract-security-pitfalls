# Smart Contract Security Demos

This repository contains simple Solidity contracts that demonstrate common smart contract vulnerabilities and their safe patterns. Each example is structured for clarity and education purposes.


## Structure

```bash
src/
  access/           # Access control issues & fixes
  reentrancy/       # Reentrancy vulnerabilities
  underflow/        # Arithmetic underflow (pre-Solidity 0.8)
```

## How to Use

1. Install Foundry if you haven't: https://book.getfoundry.sh/getting-started/installation
2. Clone this repository:

```bash
git clone https://github.com/OffchainLabs/smart-contract-security-pitfalls.git
cd smart-contract-security-pitfalls
```
3. Build contracts:

```bash
forge build
```

## Notes

- Each folder contains vulnerable and fixed versions of contracts.
- Solidity ≥0.8 already protects against arithmetic overflow/underflow, but older code or unchecked blocks may still be unsafe.
- These demos are for educational purposes only.