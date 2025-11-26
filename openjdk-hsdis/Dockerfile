FROM ubuntu:22.04

# Install build tools and dependencies for hsdis
RUN apt update -y
RUN apt install -y \
    git \
    file \
    build-essential \
    libasound2-dev \
    libcups2-dev \
    libfontconfig1-dev \
    autoconf \
    zip \
    unzip \
    binutils-dev \
    libbfd-dev \
    texinfo \
    libcapstone-dev \
    wget \
    openjdk-21-jdk \
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxrandr-dev \
    libxtst-dev \
    libxt-dev


WORKDIR /tmp

RUN git clone --branch jdk-21+35 --single-branch https://github.com/openjdk/jdk.git

WORKDIR /tmp/jdk/

RUN chmod +x configure
RUN ./configure --with-hsdis=capstone
RUN make build-hsdis

RUN JAVA_HOME="$(dirname "$(dirname "$(readlink -f "$(which java)")")")" \
        && echo $JAVA_HOME \
        && cp build/linux-*/support/hsdis/*.so "$JAVA_HOME/lib/server/"

WORKDIR /

RUN wget https://repo1.maven.org/maven2/org/openjdk/jol/jol-cli/0.17/jol-cli-0.17-full.jar -O jol-cli.jar

CMD ["java", "-version"]


# docker buildx build -f Dockerfile -t java-hsdis .
# docker run --rm -it  java-hsdis /bin/bash
# java -XX:+UnlockDiagnosticVMOptions -XX:+PrintAssembly -version
