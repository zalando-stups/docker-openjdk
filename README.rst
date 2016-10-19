============================
Zalando Docker OpenJDK Image
============================

This Docker base image contains OpenJDK 8 and the Zalando CA certificate.
Versions of this image will be immutable, i.e. there is no "latest" tag, but instead version numbers are incremented like::

    <JAVA_MAJOR_VERSION>_<COUNTER> (example: "8-42")

Build and test the image like that:

.. code-block:: bash

    $ sed -i 's/UPSTREAM/15.10-11/g' Dockerfile
    $ docker build -t openjdk:local .
    $ sed -i 's/UNTESTED/openjdk:local/g' Dockerfile.test
    $ docker build -t openjdk-test:local -f Dockerfile.test .
    $ docker run openjdk-test:local

You can find the `latest OpenJDK Docker image in our open source registry`_.

.. _latest OpenJDK Docker image in our open source registry: https://registry.opensource.zalan.do/teams/stups/artifacts/openjdk/tags

