#!/usr/bin/env bash

gradle_github_tag() {
  echo "************************************************************"
  local project="$1"
  local version="$2"

  echo "Creating tag of ${project} ${version}"
  # TODO fix to change only when line starts with 'version'
  # gsed -i "/version/c version=${version}" knotx-repos/${project}/gradle.properties
  gsed -i "/knotx.version/c knotx.version=${version}" knotx-repos/${project}/gradle.properties

  git_commit_and_create_tag $project $version
  echo "************************************************************"
}

gradle_github_close_tag() {
  echo "************************************************************"
  project="$1"
  dev_version="$2"

  echo "Set next development version to ${dev_version}"
  git_set_next_dev_version $project $dev_version

  git_push_changes $project
  echo "************************************************************"
}