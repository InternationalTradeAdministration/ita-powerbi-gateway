#!/usr/bin/env bash

#You'll need to log into Azure first 'sudo az acr login'
sudo az acr login --name itadataloader
sudo docker login itadataloader.azurecr.io -u itadataloader -p '$AZURE_CONTAINER_KEY'  #use container username and access key
sudo docker build -t itadataloader.azurecr.io/ita-dataloader-reporting .
sudo docker push itadataloader.azurecr.io/ita-dataloader-reporting
