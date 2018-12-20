#!/usr/bin/env bash

start_gradle_repo_release() {
  echo "************************************************************"
  local project="$1"
  local version="$2"
  echo "Starting release of ${project} ${version}"

  # Set release version
  sed -i "/version/c version=${version}" knotx-repos/${project}/gradle.properties

  # Release
  knotx-repos/${project}/gradlew -p knotx-repos/${project} publishMavenJavaPublicationToMavenLocal
  knotx-repos/${project}/gradlew -p knotx-repos/${project} publish

  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} add .
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} commit -m "Releasing ${version}"
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} tag ${version}
  echo "************************************************************"
}

close_gradle_repo_release() {
  echo "************************************************************"
  project="$1"
  dev_version="$2"
  # echo "Releasing ${project} to central"
  # TODO close repo automatically
  # NOTICE: gradle pushes more than one artifacts released with gradle to a single staging repo (e.g. knotx-1560)
  # maven deploys each repo to separate staging repo

  echo "Set next development version to ${dev_version}"
  sed -i "/version/c version=${dev_version}" knotx-repos/${project}/gradle.properties

  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} add .
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} commit -m "Set next development version to ${dev_version}"

  echo "Push changes to the repo"
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} push origin master
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} push --tags origin master
  echo "************************************************************"
}
