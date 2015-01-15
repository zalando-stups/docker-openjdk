============================
Zalando Docker OpenJDK Image
============================

This Docker base image contains OpenJDK 8 and the Zalando CA certificate.
Versions of this image will be immutable, i.e. there is no "latest" tag, but instead version numbers are incremented like::

    <OPENJDK_PACKAGE_VERSION>-<COUNTER> (example: "8u40-b09-1")

Build the Docker image and squash it with a single command:

.. code-block::

    $ ./build.sh

Test unlimited JCE strength and verify that the Zalando CA is correctly installed (this will only complete successfully from within Zalando):

.. code-block::

    $ ./test.sh zalando/openjdk:8u40-b09-1
