#!/usr/bin/env bash

VERSION="$1"
DEV_VERSION="$2"
USER="$3"
TOKEN="$4"
CURRENT_DIR="$(dirname "${0}")/"

# ToDo - better way to manage scripts includes
. "$CURRENT_DIR"helpers/git-release.sh
. "$CURRENT_DIR"helpers/github-release.sh
. "$CURRENT_DIR"helpers/maven-release.sh
. "$CURRENT_DIR"helpers/gradle-release.sh
. "$CURRENT_DIR"helpers/bintray-upload.sh

echo "############# Closing the release #############"

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
    operation="Closing release of Maven repo $project"
    echo "$opeartion"
    maven_close_release $project ${DEV_VERSION}; fail_fast_operation $? "$operation"
  else
    operation="Closing release of Gradle repo $project"
    echo "$opeartion"
    gradle_close_release $project ${DEV_VERSION}; fail_fast_operation $? "$operation"
  fi

  echo "______________________________________________________________________"
done

echo "############# Release done #############"
