#!/usr/bin/env bash

VERSION="$1"
DEV_VERSION="$2"
USER="$3"
TOKEN="$4"
CURRENT_DIR="$(dirname "${0}")/"

. "$CURRENT_DIR"helpers/maven-repo-release.sh
. "$CURRENT_DIR"/helpers/gradle-repo-release.sh
. "$CURRENT_DIR"/helpers/bintray-upload.sh

echo "############# Closing the release #############"

close_maven_repo_release knotx-dependencies ${DEV_VERSION}
close_gradle_repo_release knotx-junit5 ${DEV_VERSION}
close_maven_repo_release knotx ${DEV_VERSION}

close_gradle_repo_release knotx-forms ${DEV_VERSION}
close_gradle_repo_release knotx-data-bridge ${DEV_VERSION}
close_gradle_repo_release knotx-template-engine ${DEV_VERSION}

upload_to_bintray ${USER} ${TOKEN} ${VERSION}
close_maven_repo_release knotx-stack ${DEV_VERSION}
close_maven_repo_release knotx-example-project ${DEV_VERSION}

echo "############# Release done #############"
