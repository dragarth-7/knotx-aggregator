#!/usr/bin/env bash

PROJECT="$1"

echo "############# Building and pushing the Knotx images to Docker Hub #############"

mvn -f knotx-repos/${PROJECT}/pom.xml clean deploy -Prelease
mvn -f knotx-repos/${PROJECT}/pom.xml docker:push
