#!/usr/bin/env bash

case $1 in
    8)
        DOCKER_BASE_PATH=docker/jdk8
        ;;
    11)
        DOCKER_BASE_PATH=docker/jdk11
        ;;
    *)
        echo "Unknown JDK requested"
        exit 1
esac

# use the resolved Ubuntu base image version
echo "Ubuntu base image version: ${DEP_BASE_VERSION}"
sed -i '' "s,:latest,:${DEP_BASE_VERSION}," $DOCKER_BASE_PATH/Dockerfile
image=openjdk-$1-temp:${CDP_BUILD_VERSION}
docker build -t $image --squash -f $DOCKER_BASE_PATH/Dockerfile .

# Tidy up previous run
if [[ -f docker/test/Dockerfile ]]; then
    rm docker/test/Dockerfile
fi
cp docker/test/Dockerfile.template docker/test/Dockerfile
sed -i '' "s,UNTESTED,$image,g" docker/test/Dockerfile
docker build -t $image-test -f docker/test/Dockerfile .

# get current Java version
out=$(docker run $image-test 2>&1)
echo "$out"
# e.g. 'openjdk version "1.8.0_131"'
version=$(echo "$out" | grep 'openjdk version' | tr -d '"' | tr '_' '-' | awk '{ print $3 }')

release=registry-write.opensource.zalan.do/stups/openjdk:$version-${CDP_TARGET_BRANCH_COUNTER}

docker tag $image $release

IS_PR_BUILD=${CDP_PULL_REQUEST_NUMBER+"true"}
if [[ ${IS_PR_BUILD} != "true" ]]; then
    docker push $release
else
    echo "Image not pushed because the build is not a push to master"
fi
