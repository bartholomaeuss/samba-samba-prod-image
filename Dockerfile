FROM docker.io/library/ubuntu:22.04

USER root

RUN apt-get -y update

RUN apt-get -y install samba

ENTRYPOINT ["/usr/sbin/smbd"]

CMD ["--foreground", "--no-process-group"]
