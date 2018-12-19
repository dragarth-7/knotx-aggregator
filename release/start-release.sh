#!/usr/bin/env bash

VERSION="$1"
CURRENT_DIR="$(dirname "${0}")/"

. "$CURRENT_DIR"helpers/maven-repo-release.sh
. "$CURRENT_DIR"/helpers/gradle-repo-release.sh

echo "############# Start releases #############"

start_maven_repo_release knotx-dependencies ${VERSION}
start_gradle_repo_release knotx-junit5 ${VERSION}
start_maven_repo_release knotx ${VERSION} wiki
start_gradle_repo_release knotx-forms ${VERSION}
start_gradle_repo_release knotx-data-bridge ${VERSION}
start_gradle_repo_release knotx-template-engine ${VERSION}
start_maven_repo_release knotx-stack ${VERSION}
start_maven_repo_release knotx-example-project ${VERSION}

echo "############# Release prepared #############"
