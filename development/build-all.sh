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

fail_fast_build () {
  if (( $1 != 0 )); then
    echo "Building [$2] failed!" >&2
    exit 1
  fi
}

############################
#       Maven build        #
############################
build_with_maven () {
  # S1 root folder
  # $2 deploy
  echo "***************************************"
  echo "* Building [$1] using maven with deploy [$2]"
  echo "***************************************"
  if [[ $2 ]]; then
    mvn -f $1/pom.xml clean install deploy; fail_fast_build $? $1
  else
    mvn -f $1/pom.xml clean install; fail_fast_build $? $1
  fi
}

############################
#      Gradle build        #
############################
build_with_gradle () {
  # $1 root folder
  # $2 deploy
  echo "***************************************"
  echo "* Building [$1] using gradle with deploy [$2]"
  echo "***************************************"
  if [[ $2 ]]; then
    $1/gradlew -p $1 clean build publish --rerun-tasks; fail_fast_build $? $1
  else
    $1/gradlew -p $1 clean build publishToMavenLocal --rerun-tasks; fail_fast_build $? $1
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
