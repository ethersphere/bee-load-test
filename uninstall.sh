#!/bin/bash

set -euxo pipefail

. .env

export RELEASE="${1:-import}"

if [[ -z $NAMESPACE ]]; then 
    echo "Environment variable NAMESPACE is required." 
    echo "Example: NAMESPACE=test ./uninstall.sh"
    exit 1
fi

echo "DESTROYING BEE NODES"
helmsman -destroy -f ./helmsman-dsf/${RELEASE}.yaml -p 5

echo "DELETING BEE NODE PVCs"
kubectl delete pvc --selector=app.kubernetes.io/name=bee -n $NAMESPACE
kubectl delete pvc --selector=app.kubernetes.io/name=geth-swap -n $NAMESPACE
