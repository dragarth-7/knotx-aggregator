#!/usr/bin/env bash

VERSION="$1"
DEV_VERSION="$2"
USER="$3"
TOKEN="$4"

echo "############# Closing the release #############"

sh close-maven-repo-release.sh knotx-dependencies ${DEV_VERSION}
sh close-gradle-repo-release.sh knotx-junit5 ${DEV_VERSION}
sh close-maven-repo-release.sh knotx ${DEV_VERSION}

# TODO fix this
# if [[ -z "$SKIP_DOCKER" ]]; then
#   sh release-docker.sh knotx-stack/knotx-docker
# fi

sh close-gradle-repo-release.sh knotx-data-bridge ${DEV_VERSION}

sh release-upload-to-bintray.sh ${USER} ${TOKEN} ${VERSION}
sh close-maven-repo-release.sh knotx-stack ${DEV_VERSION}
sh close-maven-repo-release.sh knotx-example-project ${DEV_VERSION}

echo "############# Release done #############"
