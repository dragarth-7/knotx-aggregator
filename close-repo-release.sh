#!/usr/bin/env bash

PROJECT="$1"
DEV_VERSION="$2"
export GPG_TTY=$(tty)

echo "Releasing ${PROJECT} to central"
mvn -f knotx-repos/${PROJECT}/pom.xml nexus-staging:release

echo "Set next development version"
mvn -f knotx-repos/${PROJECT}/pom.xml versions:set -DnewVersion=${DEV_VERSION} -DgenerateBackupPoms=false
git add .
git commit -m "Set next development version to ${DEV_VERSION}"

echo "Push changes to the repo"
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} push origin master
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} push --tags origin master