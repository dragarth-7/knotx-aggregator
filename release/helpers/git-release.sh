#!/usr/bin/env bash

git_commit_and_create_tag() {
  local project="$1"
  local version="$2"

  echo "Generating new vesion tag"
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} add .
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} commit -m "Releasing ${version}"
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} tag ${version}
}

git_set_next_dev_version() {
  local project="$1"
  local dev_version="$2"

  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} add .
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} commit -m "Set next development version to ${dev_version}"
}

git_push_changes() {
  local project="$1"

  echo "Push changes to the repo"
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} push origin master
  git --git-dir=knotx-repos/${project}/.git --work-tree=knotx-repos/${project} push --tags origin master
}
