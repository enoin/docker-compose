FROM ubuntu:22.04

RUN apt update -y
RUN apt install -y \
    git \
    file \
    docker.io \
    curl


RUN curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | bash

RUN apt update -y && apt install -y gitlab-runner

WORKDIR /app


CMD ["/bin/bash"]


# docker buildx build -f Dockerfile -t gitlab-runner .
# docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/app gitlab-runner /bin/bash
