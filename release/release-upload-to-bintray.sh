#!/usr/bin/env bash

USER="$1"
TOKEN="$2"
VERSION="$3"

echo "#### Releasing knotx distribution to bintray ####"

upload_distros() {
  echo "Uploading knotx-stack.zip to bintray"
  curl -T knotx-repos/knotx-stack/knotx-stack-manager/target/knotx-${VERSION}.zip -u${USER}:${TOKEN} https://api.bintray.com/content/knotx/downloads/distro/${VERSION}/knotx-${VERSION}.zip

  echo "Uploading knotx-stack.tar.gz to bintray"
  curl -T knotx-repos/knotx-stack/knotx-stack-manager/target/knotx-${VERSION}.tar.gz -u${USER}:${TOKEN} https://api.bintray.com/content/knotx/downloads/distro/${VERSION}/knotx-${VERSION}.tar.gz

  echo "Uploading knotx-example.zip to bintray"
  curl -T knotx-repos/knotx-example-project/acme-stack/target/knotx-example-project-stack-${VERSION}.zip -u${USER}:${TOKEN} https://api.bintray.com/content/knotx/downloads/examples/${VERSION}/knotx-example-project-stack-${VERSION}.zip
}


# TODO: create versions automatically via header sent with curl
echo "Is version ${VERSION} created in https://bintray.com/knotx/downloads for distro and example?"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    upload_distros
else
    echo "Distros not uploaded!"
fi
