#!/usr/bin/env bash

VERSION="$1"
DEV_VERSION="$2"

echo "############# Start releases #############"

sh start-repo-release.sh knotx-dependencies ${VERSION}
sh start-repo-release.sh knotx ${VERSION} wiki
## TBD: Data bridge
sh start-repo-release.sh knotx-stack ${VERSION}
sh start-repo-release.sh example-project ${VERSION}

echo "############# Finish releases #############"

sh close-repo-release.sh knotx-dependencies ${DEV_VERSION}
sh close-repo-release.sh knotx ${DEV_VERSION}
## TBD: Data bridge
sh release-docker.sh knotx-stack/knotx-docker
sh release-distro.sh knotx-stack/knotx-stack-manager ${VERSION}
sh close-repo-release.sh knotx-stack ${DEV_VERSION}
sh close-repo-release.sh example-project ${DEV_VERSION}

echo "############# Release done #############"