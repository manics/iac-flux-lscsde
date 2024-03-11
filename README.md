# iac-flux-lscsde
Flux Configuration for LSC SDE Components

## Developer Guide
To test the changes, ensure that you are on your developer machine and that the context is set correctly to your local instance please amend the following script to use the target branch:

```bash
kubectl config use-context docker-desktop
kubectl create namespace lscsde
flux create source git lscsde --url="https://github.com/lsc-sde/iac-flux-lscsde" --branch=main --namespace=lscsde
flux create kustomization lscsde-sources --source="GitRepository/lscsde" --namespace=lscsde --path="./sources" --interval=1m --prune=true --health-check-timeout=10m --wait=false
```

This should in turn deploy all of the resulting resources on your local cluster.

