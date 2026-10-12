# Helm Chart Project

This repository contains a production-style 3-tier application Helm chart and a GitOps setup built around Argo CD and OpenBao / External Secrets.

## Project structure

- `three-tier-app/` — Helm chart for frontend, backend, and PostgreSQL
- `gitops/` — GitOps manifests for Argo CD and External Secrets

## Stack

- Frontend: `nginx:1.27-alpine`
- Backend: `kennethreitz/httpbin`
- Database: `postgres:16-alpine`
- Secrets: OpenBao + External Secrets Operator
- Deployment: Argo CD

## Install and validate

```bash
helm lint ./three-tier-app
helm template myapp ./three-tier-app
```

## GitOps pattern

- Git repository stores declarative manifests
- Argo CD syncs the application from Git
- OpenBao stores real secrets
- External Secrets converts OpenBao values into Kubernetes Secret objects

## Important note

Credentials are not stored in Git. Secrets should live in OpenBao and be pulled via ExternalSecret resources.

