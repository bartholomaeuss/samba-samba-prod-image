#!/bin/bash

sudo mkdir -pv /mnt/external_drive
sudo mkdir -pv /mnt/external_ssdrive
sudo mount -v /dev/sda1 /mnt/external_drive
sudo mount -v /dev/sdb1 /mnt/external_ssdrive

echo "/dev/sda1  /mnt/external_drive  ntfs  defaults  0  2" | sudo tee -a /etc/fstab
echo "/dev/sdb1  /mnt/external_ssdrive  ntfs  defaults  0  2" | sudo tee -a /etc/fstab

sudo lsblk -f