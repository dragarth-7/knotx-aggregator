#!/usr/bin/env bash

# Knot.x dependencies
git clone --depth 1 git@github.com:Knotx/knotx-dependencies.git knotx-repos/knotx-dependencies

# Knot.x core
git clone --depth 1 git@github.com:Cognifide/knotx.git knotx-repos/knotx

# Knot.x bridge
git clone --depth 1 git@github.com:Knotx/knotx-bridge.git knotx-repos/knotx-bridge

# Knot.x stack
git clone --depth 1 git@github.com:Knotx/knotx-stack.git knotx-repos/knotx-stack

# Knot.x example project
git clone --depth 1 git@github.com:Knotx/knotx-example-project.git knotx-repos/knotx-example-project
