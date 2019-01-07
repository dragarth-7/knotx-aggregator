#!/usr/bin/env bash

maven_start_release() {
  echo "************************************************************"
  local project="$1"
  local version="$2"
  echo "Starting release of ${project} ${version}"

  mvn -f knotx-repos/${project}/pom.xml versions:set -DnewVersion=${version} -DgenerateBackupPoms=false
  update_changelog $project $version

  mvn -f knotx-repos/${project}/pom.xml clean deploy -Prelease -DskipDocker
  git_commit_and_create_tag $project $version
  echo "************************************************************"
}

maven_close_release() {
  echo "************************************************************"
  local project="$1"
  local dev_version="$2"

  echo "Releasing ${project} to central"
  mvn -f knotx-repos/${project}/pom.xml nexus-staging:release

  echo "Set next development version to ${dev_version}"
  mvn -f knotx-repos/${project}/pom.xml versions:set -DnewVersion=${dev_version} -DgenerateBackupPoms=false
  git_set_next_dev_version $project $dev_version

  git_push_changes $project
  echo "************************************************************"
}
