============================
Zalando Docker OpenJDK Image
============================

This Docker base image contains OpenJDK 8 and the Zalando CA certificate.
Versions of this image will be immutable, i.e. there is no "latest" tag, but instead version numbers are incremented like::

    <OPENJDK_PACKAGE_VERSION>-<COUNTER> (example: "8u40-b09-2")

Build and test the image like that:

.. code-block:: bash

    $ sed -i 's/UPSTREAM/15.10-11/g' Dockerfile
    $ docker build -t docker-ubuntu:15.10-local .
    $ sed -i 's/UNTESTED/docker-ubuntu:15.10-local/g' Dockerfile.test
    $ docker build -t docker-ubuntu-test:15.10-local -f Dockerfile.test .
    $ docker run docker-ubuntu-test:15.10-local

You can find the `latest OpenJDK Docker image in our open source registry`_.

.. _latest OpenJDK Docker image in our open source registry: https://registry.opensource.zalan.do/teams/stups/artifacts/docker-openjdk/tags

