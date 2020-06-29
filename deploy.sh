#!/usr/bin/env bash

set -e

if kubectl get job/laravel-app-migrator -n docker4laravel; then
    kubectl delete job/laravel-app-migrator -n docker4laravel --wait=true;
fi

kustomize build | kubectl apply -f -

kubectl wait --for=condition=complete --timeout=30s job/laravel-app-migrator -n docker4laravel
