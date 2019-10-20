# OVH Errors
Have you ever had an incident where you updated your kernel on OVH and you find yourself at a GRUB error which makes your server not booting?

- Login into your OVH account.
- Select your server you would like to manage.
- Goto `Boot` and select `Modify`.
- `Boot in network mode`
- Kernel available: CentOS 7 x64 I always select the latest version (the bottom one)
- Root device: Usually always `/dev/md2`
- Select `Next` and `Confirm`.
- Goto `Status` and select `Reboot` and `Confirm`.
- Your server will now boot normally, however, this is OVH's quick fix to get you online and not actually fix the problem!
- Once you're logged in normally to your server copy and paste this command.
- If everything is `Successful`
- Goto `Boot` and select `Modify`.
- `Boot from the hard disk`
- Type reboot from the server and it should work properly now.

```
efi="$(grep "efi" /etc/fstab | awk '{print $1}')"
cd /
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-install $efi
```

They're solutions to do this via rescue mode, however, I've been unsuccessful to run the `grub2-install`.
