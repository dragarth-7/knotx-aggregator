#!/usr/bin/env bash

start_maven_repo_release() {
  echo "************************************************************"
  local project="$1"
  local version="$2"
  echo "Starting release of ${project} ${version}"

  mvn -f knotx-repos/${project}/pom.xml versions:set -DnewVersion=${version} -DgenerateBackupPoms=false
  
  mvn -f knotx-repos/${project}/pom.xml clean deploy -Prelease -DskipDocker
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} add .
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} commit -m "Releasing ${version}"
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} tag ${version}
  echo "************************************************************"
}

close_maven_repo_release() {
  echo "************************************************************"
  local project="$1"
  local dev_version="$2"

  echo "Releasing ${project} to central"
  mvn -f knotx-repos/${PROJECT}/pom.xml nexus-staging:release

  echo "Set next development version to ${dev_version}"
  mvn -f knotx-repos/${PROJECT}/pom.xml versions:set -DnewVersion=${dev_version} -DgenerateBackupPoms=false
  git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} add .
  git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} commit -m "Set next development version to ${dev_version}"

  echo "Push changes to the repo"
  git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} push origin master
  git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} push --tags origin master
  echo "************************************************************"
}
