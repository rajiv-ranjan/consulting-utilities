
|Command|Purpose|
|----|----|
|ls -lrt /dev \| grep -i sd|To get the list of file descriptor of device|
|fdisk /dev/sda|To start the partitioing in interactive mode|
|fdisk -l /dev/sda|To list the partitions|
|partprobe|To reload the partition changes made via (w command) fdisk. If using parted then it writes at the same time as the commands are executed|
|parted|To create partitions|
|cat /proc/filesystem |To see what file system types are in use.|
|mke2fs -t ext4 -n /dev/sda2|To create an ext2/ext3/ext4 filesystem where type choosen in ext4 and should use the partition /dev/sda2. -n option asks question before executing acting as safety net|
|cat /etc/mke2fs.conf| To see the default values that are configured for the tool to use|
|mount -t ext4 /dev/sda2 /testmountpoint|To mount the *ext4* filesystem type from device partition /dev/sda2 to the mountpoint /testmountpoint|
|mount -l -t ext4|To list all the mount points with filesystem type of ext4|
|umount /dev/sda2|To unmount the filesystem|
|||
|cat /etc/fstab|To see the mount points that will be loaded when the system reboots. |
|echo "/dev/sda2  /testmountpoint  ext4   ro,discard  0  0" >> /etc/fstab|To load the /dev/sda2 partition with read only and discard options. This is not a good idea as /dev/sda2 may change based on the device plugged in changes. Hence use UUID. See next.|
|blkid <br> <br> lsblk --fs|To see the details of block devices attached|
|echo "UUID=4d13bb60-9b2e-47d5-a024-7d2f8313b3e4  /testmountpoint  ext4   ro,discard  0  0" >> /etc/fstab|To mount the partition automatically at boot time using UUID|
|mount -a|To reload the mount points in fstab without rebooting the system|
|lsof /testmountpoint/ <br> <br>fuser -cuv /testmountpoint|To see which process and user is accessing the mountpoint/filesystem|
|||
|df -hT|To see the disk usage with filesystem type and in human readable format|
|du -hcs /etc|To retrieve disk usages of the file/directory in human readable format|


### LVM Commands
Assuming the block devices are already attached to the system
|Command|Purpose|
|----|----|
|**Check the attached block device**|
|ll /dev/disk/by-path/ |To see the devices mapped by path|
|lsblk --fs|To see the block devices with filesystems|
|**Create partition as a good practice**|
|fdisk /dev/sdb <br> lsblk --fs|To create a partition which will be claimed by lvm|
|fstransform /dev/sdb1 ext4| To transform one fs to another. Please see exhaustive documentation https://github.com/cosmos72/fstransform if you need data retention (compatibility). It present only in fedora 28 and above at the time to writing.|
|mkfs.xfs -f /dev/sdb1 |To create xfs partition |
|partprobe |To refresh the partition table|
|||
|pvcreate /dev/sdb1|To label the partition for lvm. pv stands for physical volume|
|pvcreate --metadatacopies 2 -v /dev/sdb1|To create the lvm label at the starting and end of the pv boundries. Default is 1 i.e. present at the beginning of the file|
|pvdisplay /dev/sdb1|To get the details of the pv created|
|pvs -v|To list all the pv on the system|
|pvremove /dev/sdb1|To remove the lvm label from pv|
|||


### Misc Commands
|Commands|Purpose|
|----|----|
|cat /proc/partitions|To check the partitions and there size|
|cfdisk -P s /dev/vdb|To check the partitions and there size|

Reference below article to write commands here
https://www.linuxtechi.com/create-extend-xfs-filesystem-on-lvm/
http://ask.xmodulo.com/create-mount-xfs-file-system-linux.html