#!/usr/bin/env bash

PROJECT="$1"
DEV_VERSION="$2"
export GPG_TTY=$(tty)

echo "Releasing ${PROJECT} to central"
# ToDo

echo "Set next development version"
sed -i "1s/.*/version=${DEV_VERSION}/g" knotx-repos/${PROJECT}/gradle.properties

git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} add .
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} commit -m "Set next development version to ${DEV_VERSION}"

echo "Push changes to the repo"
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} push origin master
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} push --tags origin master