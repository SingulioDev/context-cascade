# Claude-in-Chrome MCP Integration Reference

## Available Tools

### Tab Management
| Tool | Purpose | Parameters |
|------|---------|------------|
| `tabs_context_mcp` | Get available tabs | `createIfEmpty: bool` |
| `tabs_create_mcp` | Create new tab | None |

### Navigation
| Tool | Purpose | Parameters |
|------|---------|------------|
| `navigate` | Navigate to URL | `url: string, tabId: number` |

### Page Inspection
| Tool | Purpose | Parameters |
|------|---------|------------|
| `read_page` | Get accessibility tree | `tabId: number, depth?: number, filter?: string` |
| `find` | Search elements | `query: string, tabId: number` |
| `get_page_text` | Extract raw text | `tabId: number` |

### Interaction
| Tool | Purpose | Parameters |
|------|---------|------------|
| `computer` | Mouse/keyboard | `action: string, coordinate?: [x,y], tabId: number` |
| `form_input` | Set form values | `ref: string, value: any, tabId: number` |

### Verification
| Tool | Purpose | Parameters |
|------|---------|------------|
| `screenshot` | Capture screen | `tabId: number` |

## Usage Patterns

### Pattern 1: Basic Navigation
```javascript
const { tabId } = await tabs_create_mcp()
await navigate({ url: "https://example.com", tabId })
await screenshot({ tabId }) // Verify loaded
```

### Pattern 2: Form Interaction
```javascript
// Find form elements
const elements = await find({ query: "email input", tabId })
// Fill form
await form_input({ ref: elements[0].ref, value: "user@example.com", tabId })
// Verify filled
await screenshot({ tabId })
```

### Pattern 3: Complex Interaction
```javascript
// Read page structure
const tree = await read_page({ tabId, filter: "interactive" })
// Click dynamic element
await computer({
  action: "left_click",
  coordinate: [100, 200],
  tabId
})
// Verify state change
await screenshot({ tabId })
```

## Integration with Sequential-Thinking

```javascript
// Phase 1: Plan
const plan = await sequentialthinking({
  thought: "Breaking down form automation...",
  thoughtNumber: 1,
  totalThoughts: 8,
  nextThoughtNeeded: true
})

// Phase 2: Execute using claude-in-chrome tools
for (const step of plan.steps) {
  // Use appropriate MCP tool based on step.action
}
```

## Error Handling

| Error | Recovery |
|-------|----------|
| Tab not found | Call tabs_context_mcp to refresh |
| Element not found | Use find with alternative query |
| Navigation timeout | Retry with exponential backoff |
| Screenshot failed | Continue execution, log warning |
