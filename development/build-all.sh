#!/usr/bin/env bash

while getopts hr:d option
do
  case "${option}"
    in
    h) help;;
    r) ROOT=${OPTARG};;
    d) DEPLOY=true;;
  esac
done

#########################
# The command line help #
#########################
help() {
    echo "Usage: $0 [option...] " >&2
    echo
    echo "   -r                         root folder with cloned repositories"
    echo "   -d                         deploy to maven central snapshots"
    echo
    echo "Examples:"
    echo "   sh build-all.sh -r projects/knotx -d                           rebuild all repositories defined in ../repositories.cfg and deploy artifacts to maven snapshot"
    exit 1
}

############################
#       Maven build        #
############################
build_with_maven () {
  # S1 root folder
  # $2 deploy
  echo "Building [$1] with deploy [$2]"
  if [[ $2 ]]; then
    mvn -f $1/pom.xml clean install deploy
  else
    mvn -f $1/pom.xml clean install
  fi
}

############################
#      Gradle build        #
############################
build_with_gradle () {
  # $1 root folder
  # $2 deploy
  echo "Building [$1] with deploy [$2]"
  if [[ $2 ]]; then
    $1/gradlew -p $1 clean --rerun-tasks
    $1/gradlew -p $1 --rerun-tasks
    $1/gradlew -p $1 publish --rerun-tasks
  else
    $1/gradlew -p $1 clean --rerun-tasks
    $1/gradlew -p $1 --rerun-tasks
    $1/gradlew -p $1 publishToMavenLocal --rerun-tasks
  fi
}


#########################
#       Execute         #
#########################
repos=()
IFS=$'\n' read -d '' -r -a repos < ../repositories.cfg

cd $ROOT

for repo in "${repos[@]}"
do
  if [ ! -f `echo "$repo" | cut -d';' -f2`/pom.xml ]; then
    build_with_gradle `echo "$repo" | cut -d';' -f2` $DEPLOY
  else
    build_with_maven `echo "$repo" | cut -d';' -f2` $DEPLOY
  fi
done

echo "Finished!"
