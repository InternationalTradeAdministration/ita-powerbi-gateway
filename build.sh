#!/usr/bin/env bash
cd client && npm ci && npm run build
cd ..
rm -rf src/main/resources/public
cp -r client/dist src/main/resources/public
./gradlew buildJarAndCopyToDocker
