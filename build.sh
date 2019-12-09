#!/usr/bin/env bash
cd client && npm ci && npm run build
cd ..
rm -rf public
cp -r client/dist public
