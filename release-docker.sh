#!/usr/bin/env bash

PROJECT="$1"

echo "############# Pushing the Knotx images to Docker Hub #############"

mvn -f knotx-repos/${PROJECT}/pom.xml docker:push