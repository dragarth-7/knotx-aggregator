#!/usr/bin/env bash

VERSION="$1"
DEV_VERSION="$2"
USER="$3"
TOKEN="$4"

echo "############# Closing the release #############"

sh close-repo-release.sh knotx-dependencies ${DEV_VERSION}
sh close-repo-release.sh knotx ${DEV_VERSION}
## TBD: Data bridge

if [[ -z "$SKIP_DOCKER" ]]; then
  sh release-docker.sh knotx-stack/knotx-docker
fi
sh release-distro.sh knotx-stack/knotx-stack-manager ${USER} ${TOKEN} ${VERSION}
sh close-repo-release.sh knotx-stack ${DEV_VERSION}
sh close-repo-release.sh example-project ${DEV_VERSION}

echo "############# Release done #############"