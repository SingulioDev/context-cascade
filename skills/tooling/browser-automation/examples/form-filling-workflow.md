# Form Filling Workflow Example

## Task
Complete a multi-step registration form with validation.

## Complexity
High (15 actions, 5 verification points, error handling)

## Phase 1: Sequential Planning

```
Thought 1/15: Multi-step form with client-side validation
Thought 2/15: Need to handle field validation errors
Thought 3/15: Progress saved per step
Thought 4/15: Final review before submission
...
```

## Phase 2: Execution

### Step 1: Personal Information
- Navigate to registration page
- Fill name, email, date of birth
- Verify field validation (email format, age check)
- Screenshot after validation passes
- Click "Next"

### Step 2: Account Details
- Fill username, password, confirm password
- Check password strength indicator
- Verify username availability
- Screenshot after validation
- Click "Next"

### Step 3: Preferences
- Select notification preferences
- Choose privacy settings
- Verify default selections
- Screenshot preferences
- Click "Next"

### Step 4: Review
- Verify all fields populated correctly
- Check for validation errors
- Screenshot review page
- Click "Submit"

### Step 5: Confirmation
- Verify success message
- Check confirmation email sent
- Screenshot confirmation
- Extract confirmation code

## Error Handling

- Email already registered -> Clear field, show alternative
- Weak password -> Generate stronger password
- Network timeout -> Retry with exponential backoff
- Session expired -> Re-authenticate and resume

## Result

Registration completed successfully with all verification steps passed.
