# docker-fastqc

[![travis badge][travis_badge]][travis_base]
[![docker badge][docker_badge]][docker_base]
[![docker badge][automated_badge]][docker_base]

A [fastqc] container. This is basically the same container as that of biocontainers, but doesnt install fastqc in /tmp since singularity would overwrite /tmp.

    docker run -it leukgen/docker-fastqc --help

[fastqc]: https://hub.docker.com/r/biocontainers/fastqc/
[docker_base]: https://hub.docker.com/r/leukgen/docker-fastqc
[docker_badge]: https://img.shields.io/docker/build/leukgen/docker-fastqc.svg
[automated_badge]: https://img.shields.io/docker/automated/leukgen/docker-fastqc.svg
[travis_badge]: https://img.shields.io/travis/leukgen/docker-fastqc.svg
[travis_base]: https://travis-ci.org/leukgen/docker-fastqc
