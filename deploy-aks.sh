#!/usr/bin/env bash

./build-push-docker-image.sh
kubectl delete pod,service ita-dataloader-reporting
kubectl apply -f kube-config.yml
