# Zero-OS EFI Driver Automation

I didn't found out how from UEFI Shell, enable "Driver Reconnect" option to EFI Driver,
so I need to use efibootmgr to do it. Because of initramfs nature of the project, efibootmgr
can't create a Driver entry with the full path node, so we need to use UEFI Shell for that for now.

That's quite ugly but it works.

