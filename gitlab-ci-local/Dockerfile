FROM node:22-alpine
RUN apk add --no-cache git file rsync curl docker-cli

RUN apk add --no-cache \
  bash \
  git \
  openssh-client \
  rsync \
  curl \
  file \
  docker-cli

RUN npm install -g gitlab-ci-local

WORKDIR /app

CMD ["/bin/bash"]

# docker buildx build -f Dockerfile -t gitlab-ci-local .
# docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD":/app  gitlab-ci-local
# run: gitlab-ci-local --volume /var/run/docker.sock:/var/run/docker.sock job:task
