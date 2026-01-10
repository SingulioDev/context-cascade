---
name: recruiter-outreach-pipeline
description: 7-phase pipeline for personalized cold outreach to executive recruiters - from prospect research through follow-up sequences
---

# Recruiter Outreach Pipeline

## Purpose
Execute systematic, personalized cold outreach to executive recruiters for VP-Level AI Consulting services. Transforms raw prospect lists into sent emails with scheduled follow-ups.

## The 7-Phase Pipeline

```
[Prospects] -> P1:Research -> P2:Draft -> P3:QA -> P4:Email -> P5:Send -> P6:Track -> P7:Follow-up
                  |             |          |         |          |          |           |
              Parallel      Templates   Slop API  Pattern    Gmail     CSV         Calendar
              Subagents     + Anti-slop  <15      Search    Browser   Update      2-week
```

---

## Phase 1: Prospect Research (Parallel)

**Skill**: `Task("Research [name]", "prompt", "Explore")`
**Input**: Prospect names/LinkedIn URLs
**Output**: Verified facts in structured format

### Execution:
```javascript
// Launch parallel subagents (one per prospect)
Task("Research Prospect A", "Extract from LinkedIn: connection degree, mutual connections, title, company, location, followers, specialization, about section quotes, recent posts", "Explore")
Task("Research Prospect B", "...", "Explore")
// ... parallel for all prospects
```

### Data Points to Extract:
- Connection degree (1st/2nd/3rd)
- Mutual connections (names, not count)
- Full title and company
- Location (for local angle)
- Follower count (credibility signal)
- Specialization/industries served
- About section (verbatim quotes)
- Recent activity/posts (engagement hooks)

### Quality Gate:
- [ ] All facts verified from actual LinkedIn profile
- [ ] Mutual connections named (not "3 mutual connections")
- [ ] No assumptions or hallucinations
- [ ] Geographic relevance noted

### Output Format:
```csv
Name,Title,Company,Location,Specialization,Followers,Connection_Degree,Mutual_Connections,LinkedIn_URL,Primary_Hook,Specific_Reference
```

---

## Phase 2: Message Drafting

**Input**: Verified prospect facts from Phase 1
**Output**: Personalized messages (connection request + follow-up)

### Connection Request Template (200 char limit):
```
[Name], connected through [Mutual Connection]. Your [specific specialty] caught my eye. I run AI workshops for placed [industry] executives. Worth connecting?
```

### Follow-up Message Template:
```
[Name], thanks for connecting.

[Personalized hook referencing their specialty/about section]

I run free AI workshops for newly placed executives. Your candidates learn practical AI fluency before they start--the kind that makes them credible when their new [role] asks "[relevant AI question for their industry]?"

My background: BS in Biotechnology, published research, 200+ professionals trained. The workshops are free because I monetize downstream through corporate training when the [leader] asks "who taught your candidate this?"

Your candidates look prepared. [Company] looks like they placed a winner.

[Personalized close]. Worth 15 minutes to discuss?

David Youssef
dnyoussef.com
717-517-6471
```

### Anti-Slop Checklist:
- [ ] No "I hope this message finds you well"
- [ ] No "I wanted to reach out"
- [ ] No "leverage," "synergy," "unlock," "delve"
- [ ] No "exciting opportunity"
- [ ] Every quote verified from actual profile
- [ ] Business model explained transparently
- [ ] Inferential gap bridged (why THEY benefit)
- [ ] Signature complete with contact info

---

## Phase 3: Quality Assurance

**Skill**: Slop Detector API
**Input**: Draft messages from Phase 2
**Output**: Validated messages (Grade A)

### Execution:
```bash
# Start slop detector
cd Desktop/_ACTIVE_PROJECTS/slop-detector/backend
python -m uvicorn app:app --port 8000

# Test each message
curl -X POST http://localhost:8000/analyze \
  -H "Content-Type: application/json" \
  -d '{"text":"[message content]"}'
```

### Scoring:
| Grade | Score | Action |
|-------|-------|--------|
| A | 0-20 | PASS - Ready to send |
| B | 21-40 | Review flagged phrases |
| C | 41-60 | Significant rewrite needed |
| D | 61-80 | Major overhaul required |
| F | 81-100 | Reject and restart |

### Target: Score < 15 (Grade A)

### Common Fixes:
- Replace "reach out" -> "contact" or remove
- Replace "leverage" -> "use"
- Remove filler phrases entirely
- Make value proposition more direct

---

## Phase 4: Email Discovery

**Input**: Prospect names and companies
**Output**: Work email addresses with confidence levels

### Methods (Priority Order):

**1. Direct Source (HIGH confidence)**
- Company website "Contact" or "Team" page
- LinkedIn "Contact Info" section
- Professional directories (ZoomInfo, RocketReach)

**2. Pattern-Based (MEDIUM confidence)**
Search: `"[Company]" email format site:rocketreach.co OR site:hunter.io`

Common patterns:
| Pattern | Example | Frequency |
|---------|---------|-----------|
| firstname@ | ryan@company.com | 25% |
| firstnamelastinitial@ | ryans@company.com | 35% |
| firstinitiallastname@ | rsteinwandtner@company.com | 20% |
| firstname.lastname@ | ryan.steinwandtner@company.com | 15% |
| firstlast@ | ryansteinwandtner@company.com | 5% |

### Confidence Levels:
- **HIGH**: Directly sourced or company format verified with multiple examples
- **MEDIUM**: Pattern-based with format research
- **LOW**: Guessed pattern, expect bounces

### Bounce Handling:
If email bounces, try next pattern in priority order. Document failed patterns.

---

## Phase 5: Send Emails

**Method**: Gmail Browser Automation (claude-in-chrome MCP)
**Input**: Validated messages + email addresses
**Output**: Sent emails

### Execution Steps:
```javascript
// 1. Navigate to compose
navigate("https://mail.google.com/mail/u/0/#inbox?compose=new")

// 2. Wait for compose window
wait(2)
read_page(filter: "interactive")

// 3. Fill To field
form_input(ref: "To_field_ref", value: "email@domain.com")

// 4. Fill Subject field
form_input(ref: "Subject_field_ref", value: "AI workshops for your [specialty] placements")

// 5. Click body and type message
click(ref: "Body_field_ref")
type(text: "[full message content]")

// 6. Verify before send
screenshot()

// 7. Send
click(ref: "Send_button_ref")

// 8. Confirm sent
wait(2)
screenshot() // Should show "Message sent"
```

### Error Handling:
| Error | Action |
|-------|--------|
| Bounce notification | Try alternate email pattern |
| Rate limit | Wait 1 hour, retry |
| Invalid address | Mark as NEEDS_ALTERNATE in spreadsheet |
| Tab focus lost | Re-read page, get fresh refs |

---

## Phase 6: Track & Update

**File**: `Documents/recruiter_prospects.csv`
**Input**: Send confirmations/bounces
**Output**: Updated tracking spreadsheet

### Columns to Update:
```csv
Email,Preferred_Channel,Outreach_Status,Outreach_Date,Notes
```

### Status Codes:
| Code | Meaning |
|------|---------|
| NOT_CONTACTED | No outreach yet |
| MESSAGES_READY | Messages drafted |
| CONNECTION_SENT | LinkedIn request sent |
| MESSAGED | LinkedIn message sent |
| EMAIL_SENT | Email delivered |
| EMAIL_BOUNCED | Needs alternate address |
| REPLIED | Prospect responded |
| MEETING_SCHEDULED | Call booked |
| CONVERTED | Became client |
| REMOVED | Not a fit |

### Update Pattern:
```javascript
Edit(file: "recruiter_prospects.csv",
     old: "[Name],...,MESSAGES_READY,...",
     new: "[Name],...,email@domain.com,...,Email,...,EMAIL_SENT,2026-01-05")
```

---

## Phase 7: Follow-up Sequence

**Schedule**: Every 2 weeks, max 3 touches
**Method**: Google Calendar events

### Follow-up 1 (Week 2):
```
Subject: Re: [Original Subject]

[Name],

Following up on my note about AI workshops for your placed executives.

Quick question: are any of your current candidates heading into roles where AI fluency would give them an edge?

Happy to share a 2-minute overview of what the workshops cover.

David
```

### Follow-up 2 (Week 4):
```
Subject: Re: [Original Subject]

[Name],

One more ping. If AI training for placed executives isn't on your radar right now, no worries--I'll stop here.

But if timing changes, the offer stands: free workshops that make your candidates look like stars.

David
dnyoussef.com
```

### Follow-up 3 (Week 6 - Final):
```
Subject: Closing the loop

[Name],

Final note. If this isn't relevant for your practice, I understand.

If you ever want to chat about AI fluency for executive placements, I'm here.

Best,
David
```

### Calendar Event Format:
```
Title: Follow-up: [Name] ([Company])
Date: [2 weeks from send]
Description:
- Original sent: [date]
- Email: [address]
- Template: Follow-up #[1/2/3]
- Spreadsheet row: [#]
```

---

## Usage

### Full Pipeline:
```bash
/recruiter-outreach-pipeline "Process batch of 5 recruiters from prospect list"
```

### Single Phase:
```bash
/recruiter-outreach-pipeline --phase=research "Research these 3 LinkedIn profiles"
/recruiter-outreach-pipeline --phase=draft "Draft messages for researched prospects"
/recruiter-outreach-pipeline --phase=send "Send emails to MESSAGES_READY prospects"
```

### With Options:
```bash
/recruiter-outreach-pipeline --skip-qa "Quick send without slop check"
/recruiter-outreach-pipeline --linkedin-only "Use LinkedIn instead of email"
/recruiter-outreach-pipeline --schedule-followups "Create calendar events"
```

---

## Files & Locations

| File | Location | Purpose |
|------|----------|---------|
| Prospect Database | `Documents/recruiter_prospects.csv` | Master tracking |
| Message Templates | `Documents/recruiter_messages_*.md` | Drafted messages |
| Email Drafts | `Documents/recruiter_emails_batch*.md` | Email versions |
| Pipeline Docs | `Documents/recruiter-outreach-pipeline.md` | Process documentation |
| This Skill | `.claude/skills/recruiter-outreach-pipeline.md` | Executable skill |

---

## Metrics

| Metric | Target | Calculation |
|--------|--------|-------------|
| Research Rate | 100% | Prospects researched / Total |
| Draft Rate | 100% | Messages drafted / Researched |
| QA Pass Rate | >90% | Grade A / Total drafts |
| Send Rate | >95% | Sent / Validated |
| Bounce Rate | <10% | Bounced / Sent |
| Reply Rate | >10% | Replies / Delivered |
| Meeting Rate | >5% | Meetings / Delivered |

---

## Chaining

This skill chains with:
- `Skill("analyzer")` - Understand prospect priorities
- `Skill("documenter")` - Generate reports
- `Task("...", "...", "Explore")` - Research subagents

---

*Version: 1.0.0*
*Created: 2026-01-05*
*Author: David Youssef*
