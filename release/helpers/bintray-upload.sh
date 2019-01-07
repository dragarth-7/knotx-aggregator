#!/usr/bin/env bash

upload_to_bintray() {
  echo "************************************************************"
  user="$1"
  token="$2"
  version="$3"

  echo "#### Releasing knotx ${version} distributions to bintray ####"
  # TODO: create versions automatically via header sent with curl, following does not work https://bintray.com/docs/api/#_create_version
  # curl -v -d "{\"name\": \"${version}\", \"desc\": \"${version}\"}"  -H "Content-Type: application/json" -u${user}:${token} -X POST https://api.bintray.com/content/knotx/downloads/distro/versions

  echo "Uploading knotx-stack.zip to bintray"
  curl -T knotx-repos/knotx-stack/knotx-stack-manager/target/knotx-${version}.zip -u${user}:${token} https://api.bintray.com/content/knotx/downloads/distro/${version}/knotx-${version}.zip

  echo "Uploading knotx-stack.tar.gz to bintray"
  curl -T knotx-repos/knotx-stack/knotx-stack-manager/target/knotx-${version}.tar.gz -u${user}:${token} https://api.bintray.com/content/knotx/downloads/distro/${version}/knotx-${version}.tar.gz

  echo "Uploading knotx-example.zip to bintray"
  curl -T knotx-repos/knotx-example-project/acme-stack/target/knotx-example-project-stack-${version}.zip -u${user}:${token} https://api.bintray.com/content/knotx/downloads/examples/${version}/knotx-example-project-stack-${version}.zip

  echo "************************************************************"
}
