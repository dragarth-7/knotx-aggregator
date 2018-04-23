#!/usr/bin/env bash

PROJECT="$1"
VERSION="$2"
WIKI="$3"
export GPG_TTY=$(tty)

mvn -f knotx-repos/${PROJECT}/pom.xml versions:set -DnewVersion=${VERSION} -DgenerateBackupPoms=false

if [ "$WIKI" == "wiki" ]; then
  read -n1 -r -p "Prepare release documentation following https://github.com/Cognifide/knotx/blob/master/documentation/README.md. Press 'Y' if ready ..." key
  if [ "$key" != 'Y' ]; then
    echo "Abort release ${PROJECT}"
    exit
  fi
fi

mvn -f knotx-repos/${PROJECT}/pom.xml clean deploy -Prelease
git add .
git commit -m "Releasing ${VERSION}"
git tag ${VERSION}
