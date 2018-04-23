#!/usr/bin/env bash

PROJECT="$1"

mvn -f knotx-repos/${PROJECT}/pom.xml docker:push