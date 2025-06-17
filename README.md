# SAMBA/SAMBA PROD IMAGE

### Prerequisite

```bash
./hello_world.sh
```

### Deploy

```bash
./provide_container.sh
```
After providing the container the host should be restarted.

### More

```
sudo docker run -d --net=host -v ~/duplicati:/mnt/external_drive_1 -v ~/backup:/mnt/external_drive_2 --restart=unless-stopped samba:latest
```
Check the UUIDs of the external drives, preferably `external_drive_1` would be the larger drive in terms of capacity.
```
sudo lsblk -f 
```
```
sudo fdisk -l 
```


See the official
[samba](https://www.samba.org/)
documentation.
See also the official
[installation manual](https://wiki.samba.org/index.php/Distribution-specific_Package_Installation#Debian/Ubuntu).
