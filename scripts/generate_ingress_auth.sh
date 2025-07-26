#!/bin/bash
# Generate a Kubernetes secret for ingress basic authentication.
# Usage: generate_ingress_auth.sh [user] [namespace]
set -e
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 [user] [namespace]"
    exit 1
fi
USER="$1"
NAMESPACE="$2"
printf "%s:$(openssl passwd -apr1)\n" "$USER" > auth
kubectl create secret generic basic-auth --from-file=auth -n "$NAMESPACE"
rm auth
