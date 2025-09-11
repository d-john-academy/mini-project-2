#!/bin/bash

set -e

kubectl apply -f namespace.yaml
kubectl apply -f secret.yaml
kubectl apply -f ingress-nginx-controller.yaml
kubectl apply -f pvc.yaml
ATTEMPTS=0; while ! kubectl apply -f service.yaml; do ATTEMPTS=$((ATTEMPTS+1)); echo "Attempt $ATTEMPTS failed. Retrying..."; if [[ $ATTEMPTS -gt 5 ]]; then echo "Max attempts reached. Exiting."; exit 1; fi; sleep 5; done
kubectl apply -f deployment-stable.yaml
