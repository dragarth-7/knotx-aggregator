#!/usr/bin/env bash

PROJECT="$1"
VERSION="$2"
export GPG_TTY=$(tty)

echo "************************************************************"
echo "Starting release of ${PROJECT} ${VERSION}"
echo "************************************************************"

# Set release version
sed -i "1s/.*/version=${VERSION}/g" knotx-repos/${PROJECT}/gradle.properties

# Release
knotx-repos/${PROJECT}/gradlew -p knotx-repos/${PROJECT} publish

git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} add .
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} commit -m "Releasing ${VERSION}"
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} tag ${VERSION}
