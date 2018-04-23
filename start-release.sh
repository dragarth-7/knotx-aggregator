#!/usr/bin/env bash

VERSION="$1"
SKIP_DOCKER="$2"

echo "############# Start releases #############"

sh start-repo-release.sh knotx-dependencies ${VERSION}
sh start-repo-release.sh knotx ${VERSION} wiki
## TBD: Data bridge
sh start-repo-release.sh knotx-stack ${VERSION}
sh start-repo-release.sh example-project ${VERSION}

echo "############# Release prepared #############"