# Front‑running & MEV (Concepts Only)

This module stays conceptual to avoid publishing runnable exploit code.

**Key ideas**
- Transactions in a block can be reordered, inserted, or censored by builders/validators.
- Vulnerable patterns: naive Dutch auctions, public price‑setting functions, on‑chain RNG without commit‑reveal, AMM swaps leaking price impact before settlement.
- Common mitigations:
  - **Commit‑reveal** for bids/sealed values.
  - **Bounded slippage / price checks**.
  - **Batching / call markets** to reduce ordering advantage.
  - **Off‑chain signing with on‑chain settlement** (e.g., permit, meta‑tx) when appropriate.
  - **Private orderflow** and **timeouts**.

**Exercise idea**
Sketch a commit‑reveal flow: `commit(bytes32 hashOf(secret, salt))` then `reveal(secret, salt)` with a deadline. Verify commitments and ignore late reveals.
