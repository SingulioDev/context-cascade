# Testnet Faucet Automation Example

## Task
Request 1 USDC from Circle Faucet for wallet address `0x1845C11d20d1bBaBDD25753Fd2E380ec2c39C35F` on Arc testnet.

## Phase 1: Sequential Planning

User Request: "Get testnet tokens from faucet"

Sequential Thinking Output:
- Thought 1/8: Need to identify correct faucet for Arc testnet
- Thought 2/8: Navigate to Circle Faucet (https://faucet.circle.com/)
- Thought 3/8: Establish tab context and create new tab
- Thought 4/8: Verify Arc Testnet is available and selected
- Thought 5/8: Enter wallet address in form field
- Thought 6/8: Click request button
- Thought 7/8: Verify success message and transaction link
- Thought 8/8: Screenshot final state for confirmation

## Phase 2: Execution

```javascript
// Get tab context
tabs_context_mcp({ createIfEmpty: true })

// Create dedicated tab
tabs_create_mcp() // Returns: { tabId: 307140371 }

// Navigate to faucet
navigate({
  url: "https://faucet.circle.com/",
  tabId: 307140371
})

// Initial screenshot
screenshot({ tabId: 307140371 }) // Checkpoint 1

// Enter wallet address
form_input({
  ref: "ref_119",
  value: "0x1845C11d20d1bBaBDD25753Fd2E380ec2c39C35F",
  tabId: 307140371
})

// Verify form filled
screenshot({ tabId: 307140371 }) // Checkpoint 2

// User clicked submit (external action)
// Verify success

screenshot({ tabId: 307140371 }) // Checkpoint 3
read_page({ tabId: 307140371 })
```

## Result

**Success**: 1 testnet USDC sent to wallet
**Transaction**: https://testnet.arcscan.app/tx/0x49719a713a789ec1138b8c9bdc5e378fc3
**Execution Time**: ~45 seconds
**Checkpoints Captured**: 3 screenshots

## Key Learning

Arc testnet uses USDC as native gas token (stablechain design). Circle Faucet providing USDC works perfectly for Arc testnet operations, including contract deployment.

Contract successfully deployed to: `0x1D10c53dCa5931acdc8f6b8F9AA0ed674ae94171`

## Pattern Analysis

### Workflow Structure
1. **Context Establishment**: Always start with `tabs_context_mcp` and `tabs_create_mcp`
2. **Navigation**: Use `navigate` with explicit tabId
3. **Verification Checkpoints**: Screenshot before and after critical actions
4. **Form Interaction**: Use `form_input` with ref from `read_page` results
5. **Success Validation**: Read final page state and capture transaction links

### Best Practices
- Create dedicated tabs for each automation task
- Take screenshots at critical states (before input, after input, after submission)
- Verify network selection before submitting (Arc Testnet in this case)
- Extract transaction links for permanent records
- Document blockchain-specific details (e.g., USDC as gas token)

### Error Prevention
- Always verify network/testnet selection before proceeding
- Check form field population with screenshot before submission
- Wait for success confirmation before marking task complete
- Store transaction hashes for audit trail

### Time Estimates
- Simple faucet request: 30-60 seconds
- With verification and screenshots: 45-90 seconds
- Including contract deployment verification: 2-3 minutes

## Related Examples
- [Login Automation](./login-automation.md)
- [Form Filling Automation](./form-filling-automation.md)
- [Multi-Step Transaction Flows](./multi-step-transaction-flows.md)
