#!/bin/bash

user = bagi
name = BAgi-space
sudo smbpasswd -a -n ${user}

name1="${name}-tier-1"
path1="/mnt/external_drive/tier1"
comment1="Tier 1 Storage - no backup policy"

name2="${name}-tier-2"
path2="/mnt/external_drive/tier2"
comment2="Tier 2 Storage - tier 2 backup policy"

name3="${name}-tier-3"
path3="/mnt/external_drive/tier3"
comment3="Tier 3 Storage - tier 3 backup policy"

sudo bash -cv "cat << EOF >> /etc/samba/smb.conf
[${name1}]
  comment = ${comment1}
  path = ${path1}
  browsable = yes
  guest ok = yes
  read only = no
  create mask = 0755

EOF"

sudo bash -cv "cat << EOF >> /etc/samba/smb.conf
[${name2}]
  comment = ${comment2}
  path = ${path2}
  browsable = yes
  guest ok = yes
  read only = no
  create mask = 0755

EOF"

sudo bash -cv "cat << EOF >> /etc/samba/smb.conf
[${name3}]
  comment = ${comment3}
  path = ${path3}
  browsable = yes
  guest ok = yes
  read only = no
  create mask = 0755

EOF"

sudo service smbd restart
