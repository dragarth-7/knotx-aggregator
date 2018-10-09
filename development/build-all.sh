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
    echo "Usage: $0 [option...] {start|stop|restart}" >&2
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
  echo "Building [$1] with deploy [$2]"
  cd $1
  if [[ $2 ]]; then
    mvn clean install deploy
  else
    mvn clean install
  fi
  cd ..
}

############################
#      Gradle build        #
############################
build_with_gradle () {
  echo "Building [$1] with deploy [$2]"
  cd $1
  if [[ $2 ]]; then
    ./gradlew clean build publish --rerun-tasks
  else
    ./gradlew clean build publishToMavenLocal --rerun-tasks
  fi
  cd ..
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