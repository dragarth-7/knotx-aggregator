#!/usr/bin/env bash

echo "************************************************************"
echo "Updating Azure Pipeliees configurations in all repositories."
echo "************************************************************"

rm -rf knotx-repos

repos=()
IFS=$'\n' read -d '' -r -a repos < ../repositories.cfg

org=''
project=''

for repo in "${repos[@]}"
do
  org=`echo "$repo" | cut -d';' -f1`
  project=`echo "$repo" | cut -d';' -f2`

  operation="Updating Azure Pipelines configuration: $org/$project to knotx-repos/$project"
  echo "$operation"

  git clone --depth 1 "git@github.com:$org/$project.git" "knotx-repos/$project"
  cp "./azure-pipelines.yml" "knotx-repos/$project"

  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} add .
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} commit -m "Update Azure Pipelines configuration."
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} push origin master
done

echo "***************************************"
echo "Finished!"