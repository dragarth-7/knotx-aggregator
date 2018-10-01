#!/usr/bin/env bash

echo "************************************************************"
echo "Clearing knotx-repos workspace"
echo "************************************************************"

rm -rf knotx-repos

# # Knot.x dependencies
# git clone --depth 1 git@github.com:Knotx/knotx-dependencies.git knotx-repos/knotx-dependencies
#
# Knot.x junit5 project
git clone --depth 1 git@github.com:Knotx/knotx-junit5.git knotx-repos/knotx-junit5

# # Knot.x core
# git clone --depth 1 git@github.com:Cognifide/knotx.git knotx-repos/knotx
#
# # Knot.x bridge
# git clone --depth 1 git@github.com:Knotx/knotx-data-bridge.git knotx-repos/knotx-data-bridge
#
# # Knot.x stack
# git clone --depth 1 git@github.com:Knotx/knotx-stack.git knotx-repos/knotx-stack
#
# # Knot.x example project
# git clone --depth 1 git@github.com:Knotx/knotx-example-project.git knotx-repos/knotx-example-project
