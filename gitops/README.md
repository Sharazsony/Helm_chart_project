# GitOps + OpenBao pattern for the 3-tier app

This repository adopts a GitOps pattern:

- GitHub stores the declarative application and configuration manifests.
- Argo CD watches the Git repo and syncs Kubernetes resources.
- OpenBao stores the actual secret values.
- External Secrets Operator reads those values from OpenBao and creates Kubernetes Secret objects.

## Flow

1. Store secrets in OpenBao at a path such as `secret/data/three-tier-app/postgres`.
2. Configure a `ClusterSecretStore` that talks to OpenBao.
3. Create an `ExternalSecret` that maps OpenBao keys into a Kubernetes Secret.
4. Argo CD deploys the Helm chart and references the generated Kubernetes secret.

## Example OpenBao secret path

```bash
secret/data/three-tier-app/postgres
```

Example payload:

```json
{
  "data": {
    "username": "myuser",
    "password": "SuperStrongPassword123",
    "database": "mydb"
  }
}
```

## Important rule

Never store actual database credentials in GitHub. Only store non-secret values (images, replicas, ports, hostnames) in the Helm chart values.

## Install order

```bash
# 1. Install OpenBao
# 2. Enable Kubernetes auth in OpenBao
# 3. Install External Secrets Operator
# 4. Create ClusterSecretStore
# 5. Create ExternalSecret
# 6. Install Argo CD
# 7. Push chart and manifests to GitHub
# 8. Add Application resource in Argo CD
```
