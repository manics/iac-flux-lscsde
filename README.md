# iac-flux-lscsde
Flux Configuration for LSC SDE Components

## Developer Guide
To test the changes, ensure that you are on your developer machine and that the context is set correctly to your local instance please amend the following script to use the target branch:

for microk8s users:
```bash

microk8s enable dns hostpath-storage rbac
flux install
```

```bash
kubectl create namespace lscsde
kubectl create namespace lscsde-config
flux create source git lscsde --url="https://github.com/lsc-sde/iac-flux-lscsde" --branch=issues/sjt/7-local-env --namespace=lscsde
flux create kustomization lscsde-cluster-config --source="GitRepository/lscsde" --namespace=lscsde --path="./clusters/local" --interval=1m --prune=true --health-check-timeout=10m --wait=false
```

This should in turn deploy all of the resulting resources on your local cluster.

