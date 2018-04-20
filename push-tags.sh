#!/usr/bin/env bash

# Knot.x dependencies
git --git-dir=knotx-repos/knotx-dependencies/.git --work-tree=knotx-repos/knotx-dependencies push --tags origin master

# Knot.x core
git --git-dir=knotx-repos/knotx/.git --work-tree=knotx-repos/knotx push --tags origin master

# Knot.x bridge
git --git-dir=knotx-repos/knotx-bridge/.git --work-tree=knotx-repos/knotx-bridge push --tags origin master

# Knot.x stack
git --git-dir=knotx-repos/knotx-stack/.git --work-tree=knotx-repos/knotx-stack push --tags origin master

# Knot.x example project
git --git-dir=knotx-repos/knotx-example-project/.git --work-tree=knotx-repos/knotx-example-project push --tags origin master

