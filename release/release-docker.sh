#!/usr/bin/env bash

echo "############# Building and pushing the Knotx images to Docker Hub #############"

mvn -f knotx-repos/knotx-docker/pom.xml docker:push
