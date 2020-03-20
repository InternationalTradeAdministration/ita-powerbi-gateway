#!/usr/bin/env bash

./build-push-docker-image.sh
kubectl delete deployment,service ita-dataloader-reporting -n power-bi-gateway
kubectl delete ingress ita-dataloader-reporting -n power-bi-gateway

kubectl apply -f kube-config.yml
