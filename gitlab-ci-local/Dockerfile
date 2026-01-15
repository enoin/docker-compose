FROM node:22

RUN apt update -y
RUN apt install -y \
    git \
    file \
    docker.io \
    curl \
    rsync

RUN npm install -g gitlab-ci-local

WORKDIR /app

CMD ["/bin/bash"]

# docker buildx build -f Dockerfile -t gitlab-ci-local .
# docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/app gitlab-ci-local /bin/bash
