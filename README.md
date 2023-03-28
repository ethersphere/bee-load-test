# Bee storage snapshot

This repository contains all the definitions for the Bee storage snapshots used by the Swarm Team.

We're using [helmsman](https://github.com/Praqma/helmsman) to manage the deployments to our Kubernetes cluster. You can learn more about Helmsman's [desired state specification](https://github.com/Praqma/helmsman/blob/master/docs/desired_state_specification.md).

## Prerequisites

* Kubernetes 1.15
* Helm 3.0
* Helmsman 3.0
* Helm diff (>=1.6.0) [.](https://github.com/databus23/helm-diff)
* jq (expected that binary is named `jq`, not `jq-linux` etc) [.](https://github.com/stedolan/jq)

## Installing

### Init
For initial deployment of isolated Bee cluster execute:

```bash
$ NAMESPACE=storage-snapshot ./install.sh init
```

It will execute `helmsman-dsf/init.yaml` Helmsman DSF file.

Helmsman DSF files use official [Bee Helm Chart](https://github.com/ethersphere/helm/tree/master/charts/bee) and custom [Ethereum Geth Chart](https://github.com/ethersphere/helm/tree/master/charts/geth-swap), and both are deployed in the same Kubernetes namespace.

**Note:** Everyone should update name of the namespace to avoid overlapping with others if working on the same Kubernetes cluster. 

:red_circle: Use `.env.example` to create `.env` and specify your AWS account ID inside `.env` file using `export AWS_ACCOUNT_ID=`

### Export
For exporting all cluster data Bee and Geth nodes:

```bash
$ NAMESPACE=storage-snapshot ./install.sh export latest
```

**Note:** By default it will use version `latest`, if you specify custom version (it can bee whatever single string) cluster data will be uploaded to both, custom version and latest.

### Import
For importing all cluster data Bee and Geth nodes:

```bash
$ NAMESPACE=storage-snapshot ./install.sh import latest
```

### Nuke
For importing nuking all Beenodes:

```bash
$ NAMESPACE=storage-snapshot ./install.sh nuke
```

**Note:** After nuke is done you have to deploy `init` again.

## Configuration

Configuration parameters can be set in 2 ways:
* in the Helmsman DSF files, with the field **set** inside `./helmsman-dsf` folder
* in the Helm values files inside `./helm-values` folder


### Uninstall

To destroy everything run:

```bash
$ NAMESPACE=storage-snapshot ./uninstall.sh
```

### Load test deployment

To deploy/undeploy load test alone use these commands

```bash
NAMESPACE=testnet-gateway helmsman -apply -subst-env-values -f ./helmsman-dsf/init.yaml -target=beekeeper-load-test
NAMESPACE=testnet-gateway helmsman -destroy -subst-env-values -f ./helmsman-dsf/init.yaml -target=beekeeper-load-test
```
