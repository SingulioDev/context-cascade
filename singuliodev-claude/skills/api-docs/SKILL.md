

---
name: api-docs
version: 1.0.0
description: |
  Generate and maintain comprehensive API documentation using OpenAPI 3.0, Swagger UI, and GraphQL Playground. Use when documenting REST APIs, GraphQL services, or creating API reference materials. Ensu
category: delivery
tags:
- delivery
- development
- workflow
author: ruv
---

# API Documentation Generator (Gold Tier)

## When to Use This Skill

- **API Development**: Building or documenting REST APIs, GraphQL APIs, or other web services
- **API Versioning**: Managing multiple API versions or migration strategies
- **Developer Experience**: Creating interactive documentation for API consumers
- **OpenAPI/Swagger**: Generating or maintaining OpenAPI specifications
- **Integration Work**: Helping external teams understand and use your APIs

## When NOT to Use This Skill

- **Non-API Documentation**: General code documentation, user manuals, or internal wikis
- **No API Surface**: Pure frontend apps, CLI tools, or embedded systems without APIs
- **Legacy Systems**: APIs without code access or with undocumented proprietary protocols
- **Incompatible Stacks**: Non-HTTP protocols (MQTT, gRPC) requiring specialized tooling

## Success Criteria

- [ ] API endpoints fully documented with request/response schemas
- [ ] Authentication and authorization flows clearly explained
- [ ] Interactive API explorer (Swagger UI/GraphQL Playground) functional
- [ ] Error codes and handling strategies documented
- [ ] Rate limiting and usage guidelines specified
- [ ] Code examples provided for common use cases
- [ ] Versioning strategy documented if applicable

## Edge Cases to Handle

- **Missing Type Annotations**: Infer schemas from runtime behavior or database models
- **Dynamic Routes**: Document parameterized endpoints and path variables
- **Nested Resources**: Handle complex resource hierarchies and relationships
- **File Uploads**: Document multipart/form-data and binary payloads
- **Webhooks**: Document callback URLs and event payloads
- **Deprecated Endpoints**: Mark sunset dates and migration paths

## Guardrails

- **NEVER** expose internal implementation details or security vulnerabilities in public docs
- **ALWAYS** validate generated specs against OpenAPI/GraphQL schema validators
- **NEVER** ship documentation without testing example requests
- **ALWAYS** include authentication requirements for protected endpoints
- **NEVER** assume default values - explicitly document all parameters
- **ALWAYS** document error responses, not just success cases

## Evidence-Based Validation

- [ ] Run generated OpenAPI spec through swagger-cli validate
- [ ] Test all documented endpoints with actual HTTP requests
- [ ] Verify GraphQL schema with graphql-schema-linter
- [ ] Check accessibility of interactive docs with axe-core
- [ ] Validate examples compile and execute successfully
- [ ] Review documentation with API consumers for clarity

Generate production-quality API documentation with OpenAPI 3.0, automated validation, and interactive documentation formats.

## When to Use This Skill

Use when documenting new or existing APIs, creating REST API specifications, maintaining GraphQL schema documentation, or generating interactive API explorers with Swagger UI/GraphQL Playground. Ideal for API-first development, maintaining accurate documentation, and ensuring OpenAPI 3.0 compliance.

## API Documentation Types

### REST API Documentation
- OpenAPI 3.0 specifications
- Endpoint descriptions and parameters
- Request/response examples
- Authentication schemes
- Error codes and handling

### GraphQL Documentation
- Schema definitions
- Query and mutation documentation
- Type system reference
- Resolver documentation

## Process

1. **Analyze API structure**
   - Identify all endpoints/operations
   - Document request/response schemas
   - Define authentication requirements
   - Catalog error responses

2. **Generate OpenAPI/GraphQL spec**
   - Write structured YAML/SDL definitions
   - Include comprehensive examples
   - Document edge cases
   - Add usage guidelines

3. **Create interactive documentation**
   - Configure Swagger UI for REST APIs
   - Set up GraphQL Playground
   - Add authentication testing support
   - Enable "Try It Out" fu

