#!/usr/bin/env bash

VERSION="$1"
DEV_VERSION="$2"
USER="$3"
TOKEN="$4"
CURRENT_DIR="$(dirname "${0}")/"

# ToDo - better way to manage scripts includes
. "$CURRENT_DIR"helpers/git-release.sh
. "$CURRENT_DIR"helpers/github-release.sh
. "$CURRENT_DIR"helpers/maven-release.sh
. "$CURRENT_DIR"helpers/gradle-release.sh
. "$CURRENT_DIR"helpers/bintray-upload.sh

echo "############# Closing the release #############"

maven_close_release knotx-dependencies ${DEV_VERSION}
gradle_close_release knotx-junit5 ${DEV_VERSION}
maven_close_release knotx ${DEV_VERSION}

gradle_close_release knotx-forms ${DEV_VERSION}
gradle_close_release knotx-data-bridge ${DEV_VERSION}
gradle_close_release knotx-template-engine ${DEV_VERSION}

upload_to_bintray ${USER} ${TOKEN} ${VERSION}
maven_close_release knotx-stack ${DEV_VERSION}
maven_close_release knotx-example-project ${DEV_VERSION}

echo "############# Release done #############"
