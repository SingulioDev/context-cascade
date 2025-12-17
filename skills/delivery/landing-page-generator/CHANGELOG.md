# Changelog

All notable changes to the Landing Page Generator skill will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-XX

### Added

- Initial release of Landing Page Generator skill
- 6-phase SOP implementation:
  - Phase 1: Research (AI researches current best practices)
  - Phase 2: Copy (AI writes landing page copy)
  - Phase 3: Inspiration (Firecrawl branding extraction + screenshot capture)
  - Phase 4: Build (AI generates HTML/CSS/JS)
  - Phase 5: Iterate (Chat + Cursor refinement loop)
  - Phase 6: Deploy (Netlify CLI automation)

### Helper Scripts

- `firecrawl-scraper.js` - Extracts branding guidelines from any URL
- `screenshot-capture.js` - Full-page screenshot via Puppeteer
- `netlify-deploy.js` - Automated Netlify deployment

### Agent Mapping

| Phase | Primary Agent | Capabilities |
|-------|---------------|--------------|
| Research | researcher | web-research, synthesis |
| Copy | content-writer | copywriting, marketing |
| Inspiration | researcher | scraping, screenshot |
| Build | coder | HTML/CSS/JS, design |
| Iterate | coder | refactoring, review |
| Deploy | cicd-engineer | CI/CD, Netlify |

### Documentation

- Full SKILL.md with input/output contracts
- GraphViz process diagram
- Example invocations for SaaS and local business pages
- Recursive improvement integration hooks

### Integration

- Phase 0 expertise loading for marketing/frontend domains
- Memory MCP integration for research storage
- Eval harness benchmark definitions
- Meta-loop skill-forge compatibility

---

## [Unreleased]

### Planned

- Multi-page site generation
- A/B testing variant generation
- Integration with analytics (Plausible, GA4)
- Custom CMS integration (Sanity, Contentful)
- E-commerce checkout flow support

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2025-01 | Initial release |
