#!/bin/sh

IMG=$1
[ -z "$IMG" ] && echo "Usage: $0 <imagename>" && exit 1

cd $(dirname $0)/test
javac jcetest/JCETest.java || exit $?
javac catest/CATest.java || exit $?

sed "s#__JAVA_IMAGE__#$IMG#g" Dockerfile.template > Dockerfile || exit 1
docker build -t $IMG-test . || exit $?

docker run -w / -t $IMG-test java jcetest.JCETest
JCE_RESULT=$?

[ $JCE_RESULT -eq 0 ] && echo "TEST JCE: OK (JCE is unlimited)" || echo "TEST JCE: FAILED (JCE is restricted)"

docker run -w / -t $IMG-test java catest.CATest
CA_RESULT=$?

[ $CA_RESULT -eq 0 ] && echo "TEST CA: OK (CA is trusted)" || echo "TEST CA: FAILED (CA is not trusted)"

if [ $JCE_RESULT -eq 0 -a $CA_RESULT -eq 0 ]; then
	echo "Image verified!"
	exit 0
else
	echo "Image broken!"
	exit 1
fi
