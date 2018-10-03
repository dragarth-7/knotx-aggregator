#!/usr/bin/env bash

PROJECT="$1"
DEV_VERSION="$2"
export GPG_TTY=$(tty)

echo "Releasing ${PROJECT} to central"
# TODO close repo automatically
# NOTICE: gradle pushes all artifacts released with gradle to a single staging repo (e.g. knotx-1560)
# maven deploys each repo to separate staging repo

echo "Set next development version"
sed -i "1s/.*/version=${DEV_VERSION}/g" knotx-repos/${PROJECT}/gradle.properties

git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} add .
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} commit -m "Set next development version to ${DEV_VERSION}"

echo "Push changes to the repo"
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} push origin master
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} push --tags origin master
