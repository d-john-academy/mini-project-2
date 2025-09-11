#!/bin/bash

set -e

kubectl apply -f namespace.yaml
kubectl apply -f secret.yaml
kubectl apply -f pvc.yaml
kubectl apply -f ingress-nginx-controller.yaml

