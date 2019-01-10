#!/usr/bin/env bash

VERSION="$1"
CURRENT_DIR="$(dirname "${0}")/"

# ToDo - better way to manage scripts includes
. "$CURRENT_DIR"helpers/git-release.sh
. "$CURRENT_DIR"helpers/github-release.sh
. "$CURRENT_DIR"helpers/maven-release.sh
. "$CURRENT_DIR"helpers/gradle-release.sh

echo "############# Start releases #############"

maven_start_release knotx-dependencies ${VERSION}
gradle_start_release knotx-junit5 ${VERSION}
maven_start_release knotx ${VERSION} wiki
gradle_start_release knotx-forms ${VERSION}
gradle_start_release knotx-data-bridge ${VERSION}
gradle_start_release knotx-template-engine ${VERSION}
maven_start_release knotx-stack ${VERSION}
# Set version in gradle in example project
# TODO: release example using gradle to resolve stack dependencies properly, remember to update maven version
gradle_set_project_version knotx-example-project ${VERSION}
maven_start_release knotx-example-project ${VERSION}

echo "############# Release prepared #############"
