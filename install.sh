#!/bin/bash

set -euxo pipefail

. .env

if [[ -z ${AWS_ACCOUNT_ID} ]]; then
    echo "Environment variable AWS_ACCOUNT_ID is required." 
    echo "Specify it inside .env file"
    exit 1
fi  

export VERSION="${2:-latest}"

if [[ -z ${NAMESPACE} ]]; then 
    echo "Environment variable NAMESPACE is required." 
    echo "Example: NAMESPACE=test ./install.sh"
    exit 1
fi

if [[ -z ${1} ]]; then
    echo "Action is required."
    echo "Specify either init|export|import."
    exit 1
fi

echo "INSTALLING"
helmsman -apply -subst-env-values -f ./helmsman-dsf/"${1}".yaml -p 10
