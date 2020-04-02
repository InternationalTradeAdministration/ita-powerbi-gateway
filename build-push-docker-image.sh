#!/usr/bin/env bash

#You'll need to log into Azure first 'sudo az acr login'
sudo az acr login --name $AZURE_CONTAINER_USER
sudo docker login $AZURE_CONTAINER_USER.azurecr.io -u $AZURE_CONTAINER_USER -p $AZURE_CONTAINER_KEY  #use container username and access key
sudo docker build -t $AZURE_CONTAINER_USER.azurecr.io/ita-powerbi-gateway .
sudo docker push $AZURE_CONTAINER_USER.azurecr.io/ita-powerbi-gateway:latest
