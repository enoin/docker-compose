FROM ubuntu:22.04

RUN apt-get update
RUN <<EOF

apt-get install --no-install-recommends -y \
    inetutils-ping \
    inetutils-ftp \
    inetutils-telnet \
    inetutils-traceroute \
    netcat \
    nmap \
    ssh

EOF

CMD "/bin/bash"

