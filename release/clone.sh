#!/usr/bin/env bash

CURRENT_DIR="$(dirname "${0}")/"

# ToDo - better way to manage scripts includes
. "$CURRENT_DIR"helpers/misc.sh

echo "************************************************************"
echo "Cloning knotx repositories to release workspace"
echo "************************************************************"

rm -rf knotx-repos

repos=()
IFS=$'\n' read -d '' -r -a repos < to-release.cfg

org=''
project=''

for repo in "${repos[@]}"
do
  org=`echo "$repo" | cut -d';' -f1`
  project=`echo "$repo" | cut -d';' -f2`

  operation="Cloning: $org/$project to knotx-repos/$project"
  echo "$operation"

  git clone --depth 1 "git@github.com:$org/$project.git" "knotx-repos/$project"; fail_fast_operation $? "$operation"
  echo "______________________________________________________________________"
done
