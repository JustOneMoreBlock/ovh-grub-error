#!/bin/bash

yum -y install psmisc net-tools

# Yum Update
yum clean all
yum -y update
yum -y reinstall kernel kernel-headers

# SELinux
/sbin/setenforce 0
sed -i 's/SELINUX=enforcing/\ESELINUX=disabled/g' /etc/selinux/config
echo 0 >/selinux/enforce

# Fix Grub (Only OVH)
efi="$(grep "efi" /etc/fstab | awk '{print $1}')"
cd /
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-install $efi
