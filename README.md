# SAMBA/SAMBA PROD IMAGE

### Prerequisite


```bash
./hello_world.sh
```

### Windows

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
[duplicati](https://duplicati.readthedocs.io/en/latest/)
documentation.
See also the official
[installation manual](https://duplicati.readthedocs.io/en/latest/02-installation/).
