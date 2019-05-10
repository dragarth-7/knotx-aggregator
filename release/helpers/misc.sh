#!/usr/bin/env bash

fail_fast_operation () {
  if (( $1 != 0 )); then
    echo "Operation: [$2] failed!" >&2
    exit 1
  fi
}

is_maven_repo () {
  test -f "$1/pom.xml"
}
