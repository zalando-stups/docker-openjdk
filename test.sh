#!/bin/sh

IMG=$1
[ -z "$IMG" ] && echo "Usage: $0 <imagename>" && exit 1

cd $(dirname $0)/test
javac jcetest/JCETest.java || exit $?

sed "s#__JAVA_IMAGE__#$IMG#g" Dockerfile.template > Dockerfile || exit 1
docker build -t $IMG-test . || exit $?


docker run -w / -t $IMG-test java jcetest.JCETest
JCE_RESULT=$?

[ $JCE_RESULT -eq 0 ] && echo "TEST JCE: OK (JCE is unlimited)" || echo "TEST JCE: FAILED (JCE is restricted)"

if [ $JCE_RESULT -eq 0 ]; then
	echo "Image verified!"
	exit 0
else
	echo "Image broken!"
	exit 1
fi
