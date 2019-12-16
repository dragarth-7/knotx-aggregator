#!/usr/bin/env bash

update_changelog() {
  local project="$1"
  local version="$2"

  gsed -i '/List of changes that are finished but not yet released in any final version./a \
\
## Version '"${version}"'' knotx-repos/${project}/CHANGELOG.md
}
