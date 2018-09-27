#!/usr/bin/env bash

VERSION="$1"

echo "############# Start releases #############"

sh start-maven-repo-release.sh knotx-dependencies ${VERSION}
sh start-gradle-repo-release.sh knotx-junit5 ${VERSION}
sh start-maven-repo-release.sh knotx ${VERSION} wiki
sh start-gradle-repo-release.sh knotx-data-bridge ${VERSION}
sh start-maven-repo-release.sh knotx-stack ${VERSION}
sh start-maven-repo-release.sh knotx-example-project ${VERSION}

echo "############# Release prepared #############"