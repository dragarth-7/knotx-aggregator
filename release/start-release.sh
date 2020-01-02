#!/usr/bin/env bash

VERSION="$1"
CURRENT_DIR="$(dirname "${0}")/"

# ToDo - better way to manage scripts includes
. "$CURRENT_DIR"helpers/git-release.sh
. "$CURRENT_DIR"helpers/github-release.sh
. "$CURRENT_DIR"helpers/gradle-github-tag.sh
. "$CURRENT_DIR"helpers/maven-release.sh
. "$CURRENT_DIR"helpers/gradle-release.sh
. "$CURRENT_DIR"helpers/misc.sh

echo "############# Start releases #############"

export GPG_TTY=$(tty)

echo "Clearing caches"
# ToDo make it optional
rm -rf ~/.m2/repository/io/knotx/
rm -rf ~/.gradle/caches/*

repos=()
IFS=$'\n' read -d '' -r -a repos < to-release.cfg

org=''
project=''
operation=''

for repo in "${repos[@]}"
do
  org=`echo "$repo" | cut -d';' -f1`
  project=`echo "$repo" | cut -d';' -f2`

  if [[ -f "knotx-repos/$project/pom.xml" ]]; then
    operation="Releasing Maven repo $project"
    echo "$operation"
    maven_start_release $project ${VERSION}; fail_fast_operation $? "$operation"
  else
    if grep -q "releasable=false" "knotx-repos/${project}/gradle.properties"; then
      operation="Tagging repo $project"
      echo "$operation"
      gradle_github_tag $project ${VERSION}; fail_fast_operation $? "$operation"
    else
      operation="Releasing Gradle repo $project"
      echo "$operation"
      gradle_start_release $project ${VERSION}; fail_fast_operation $? "$operation"
    fi
  fi

  echo "______________________________________________________________________"
done

echo "############# Release prepared #############"
