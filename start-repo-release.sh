#!/usr/bin/env bash

PROJECT="$1"
VERSION="$2"
WIKI="$3"
export GPG_TTY=$(tty)

mvn -f knotx-repos/${PROJECT}/pom.xml versions:set -DnewVersion=${VERSION} -DgenerateBackupPoms=false

if [ "$WIKI" == "wiki" ]; then
  echo "#########################################################################################################################"
  echo "#### Prepare release documentation following https://github.com/Cognifide/knotx/blob/master/documentation/README.md. ####"
  echo "-------------------------------------------------------------------------------------------------------------------------"
  read -n1 -r -p "Press 'Y' if ready ..." key
  if [ "$key" != 'Y' ]; then
    echo "Abort release ${PROJECT}"
    exit
  fi
fi

OPT=

if [[ ! -z "$SKIP_DOCKER" ]]; then
  OPT="-DskipDocker"
fi

mvn -f knotx-repos/${PROJECT}/pom.xml clean deploy -Prelease ${OPT}
git add .
git commit -m "Releasing ${VERSION}"
git tag ${VERSION}
