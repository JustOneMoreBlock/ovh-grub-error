# OVH Errors
Have you ever had an incident where you updated your kernel on OVH and you find yourself at a GRUB console error which makes your server unable to boot?

### Run this before rebooting your server, and you can avoid below.
```
yum -y install wget; apt-get install wget; wget https://raw.githubusercontent.com/JustOneMoreBlock/ovh-grub-error/master/fix-boot.sh -O fix-boot.sh; sh fix-boot.sh; echo "Reboot"
```

- Login into your OVH account.
- Select your server you would like to manage.
- From the OVH Account Manager, Goto `Boot` and select `Modify`.
- `Boot in network mode`
- Kernel available: I always select the latest version (`the bottom one`)
- Root device: `/dev/md2` (Usually)
- Select `Next` and `Confirm`.
- From the OVH Account Manager, Goto `Status` and select `Reboot` and `Confirm`.
- Your server will now boot normally, however, this is OVH's quick fix to get you online and not actually fix the problem!
- You should now be able to access your server manually and we can attept to fix your problem.

Run this command:
```
efi="$(grep "efi" /etc/fstab | awk '{print $1}')"
echo $efi
```
If you see an output of `/dev/XXX` in theory this should work correctly and able to move on the next step.

Make sure you're in the `cd /`:
```
cd /
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-install $efi
```

- If everything is `Successful`
- From the OVH Account Manager, Goto `Boot` and select `Modify`.
- `Boot from the hard disk`
- Type reboot from the server and it should work properly now.

They're solutions to do this via rescue mode, however, I've been unsuccessful to run the `grub2-install`.

If you get an error of
```
/bin/bash: Permission denied
```

Probably says `Enforcing` and should be `Permissive` or `Disabled`
```
/sbin/getenforce
/sbin/setenforce 0
```
