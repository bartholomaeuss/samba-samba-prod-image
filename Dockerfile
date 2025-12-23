FROM docker.io/library/ubuntu:22.04

USER root

RUN apt-get -y update
RUN apt-get -y install samba

RUN groupadd -g 3000 grp_backup
RUN useradd -u 2001 -g 3000 -s /usr/sbin/nologin smb_backup_desktop-u2
RUN usermod -aG grp_backup smb_backup_desktop-u2

ENTRYPOINT ["/usr/sbin/smbd"]

CMD ["--foreground", "--no-process-group"]
