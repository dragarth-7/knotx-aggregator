#!/usr/bin/env bash

PROJECT="$1"
VERSION="$2"
WIKI="$3"
export GPG_TTY=$(tty)

echo "************************************************************"
echo "Starting release of ${PROJECT} ${VERSION}"
echo "************************************************************"

mvn -f knotx-repos/${PROJECT}/pom.xml versions:set -DnewVersion=${VERSION} -DgenerateBackupPoms=false

# if [ "$WIKI" == "wiki" ]; then
#   echo "#########################################################################################################################"
#   echo "#### Prepare release documentation following https://github.com/Cognifide/knotx/blob/master/documentation/README.md. ####"
#   echo "-------------------------------------------------------------------------------------------------------------------------"
#   read -n1 -r -p "Press 'Y' if ready ..." key
#   if [ "$key" != 'Y' ]; then
#     echo "Abort release ${PROJECT}"
#     exit
#   fi
# fi

mvn -f knotx-repos/${PROJECT}/pom.xml clean deploy -Prelease -DskipDocker
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} add .
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} commit -m "Releasing ${VERSION}"
git --git-dir=knotx-repos/${PROJECT}/.git --work-tree=knotx-repos/${PROJECT} tag ${VERSION}
