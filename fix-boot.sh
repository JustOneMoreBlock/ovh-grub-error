#!/bin/bash

# bash fix-boot.sh [rescue]

efi="$(grep "efi" /etc/fstab | awk '{print $1}')"
boot=$1

yum clean all
yum -y update
yum -y reinstall kernel kernel-headers

/sbin/setenforce 0
sed -i 's/SELINUX=enforcing/\ESELINUX=disabled/g' /etc/selinux/config

function fix-boot {
	cd /
	grub2-mkconfig -o /boot/grub2/grub.cfg
	grub2-install $efi
}

# Fix Grub
# Look into a solution to auto-detect rescue mode.
if [ "${boot}" == "rescue" ]; then
	sudo mount /dev/sdxy /mnt
	sudo mount --bind /dev /mnt/dev
	sudo mount --bind /proc /mnt/proc
	sudo mount --bind /sys /mnt/sys
	fix-grub
	sudo chroot /mnt
	sudo umount /mnt/dev
	sudo umount /mnt/proc
	sudo umount /mnt/sys
	sudo umount /mnt
else
	fix-boot
fi
