#!/usr/bin/env bash

gradle_start_release() {
  echo "************************************************************"
  local project="$1"
  local version="$2"
  echo "Starting release of ${project} ${version}"

  # Set release version
  set_project_version $project $version
  update_changelog $project $version

  # Release
  knotx-repos/${project}/gradlew -p knotx-repos/${project} publishMavenJavaPublicationToMavenLocal
  knotx-repos/${project}/gradlew -p knotx-repos/${project} publish

  git_commit_and_create_tag $project $version
  echo "************************************************************"
}

gradle_close_release() {
  echo "************************************************************"
  project="$1"
  dev_version="$2"
  # echo "Releasing ${project} to central"
  # TODO close repo automatically
  # NOTICE: gradle pushes more than one artifacts released with gradle to a single staging repo (e.g. knotx-1560)
  # maven deploys each repo to separate staging repo

  echo "Set next development version to ${dev_version}"
  set_project_version $project $dev_version

  git_set_next_dev_version $project $dev_version

  git_push_changes $project
  echo "************************************************************"
}

gradle_set_project_version() {
  project="$1"
  version="$2"

  sed -i "/version/c version=${version}" knotx-repos/${project}/gradle.properties
}
