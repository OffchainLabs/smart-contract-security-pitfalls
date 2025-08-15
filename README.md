# Smart Contract Security Pitfalls — Code Lab

Hands-on examples for a short workshop covering:
- Reentrancy
- Arithmetic Over/Underflow
- Access Control Issues
- Unchecked External Calls
- (Docs only) Front‑running & MEV

## Quick start (Foundry)
1) Install Foundry if you haven't: https://book.getfoundry.sh/getting-started/installation
2) Install deps inside this repo:
```bash
forge install foundry-rs/forge-std@v1.9.6
forge install OpenZeppelin/openzeppelin-contracts@v5.0.2
```
3) Run tests:
```bash
forge test -vvv
```

## What's inside
- `src/reentrancy/` — a vulnerable vault, an attacker, and a fixed vault using checks-effects-interactions + `ReentrancyGuard`.
- `src/overflow/` — an underflow demo showing how `unchecked` can reintroduce bugs even on Solidity ≥0.8, plus a safe version.
- `src/access/` — missing access checks vs. a fix using OpenZeppelin `Ownable`.
- `src/unchecked-call/` — ignoring ERC‑20 return values vs. using `SafeERC20`.

MEV is discussed in `docs/MEV.md` with patterns and mitigations; no runnable exploit code is included.

## Notes
- Contracts use Solidity 0.8.24.
- Tests use `forge-std`'s `Test` utilities.
