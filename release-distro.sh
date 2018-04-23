#!/usr/bin/env bash

USER="$1"
TOKEN="$2"
VERSION="$3"

echo "#### Releasing knotx distribution to bintray ####"

read -n1 -r -p "Go to bintray [https://bintray.com/knotx/downloads/distro] and create ${VERSION} version. Press 'Y' if ready ..." key
if [ "$key" != 'Y' ]; then
  echo "Abort bintray upload"
  exit
fi

echo "Upload zip to bintray"
curl -T knotx-repos/knotx-stack/knotx-stack-manager/target/knotx-${VERSION}.zip -u${USER}:${TOKEN} https://api.bintray.com/content/knotx/downloads/distro/${VERSION}/knotx-${VERSION}.zip

echo "Upload tar.gz to bintray"
curl -T knotx-repos/knotx-stack/knotx-stack-manager/target/knotx-${VERSION}.tar.gz -u${USER}:${TOKEN} https://api.bintray.com/content/knotx/downloads/distro/${VERSION}/knotx-${VERSION}.tar.gz
