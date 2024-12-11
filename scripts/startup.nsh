@echo -off

echo "=========================================="
echo "== Zero-OS Certified Node Bootstrapping =="
echo "=========================================="
echo ""

if exist FS0:\DRIVER\APPLY.EFI then
  echo " - DRIVER\APPLY.EFI      : found"
  goto checkdrv
else
  goto missing
endif

:checkdrv
if exist FS0:\DRIVER\8086125b.efidrv then
  echo " - DRIVER\8086125B.EFIDRV: found"
  goto checkipxe
else
  goto missing
endif

:checkipxe
if exist FS0:\EFI\BOOT\ZOS.EFI then
  echo " - EFI\BOOT\ZOS.EFI      : found"
  goto checklock
else
  goto missing
endif

:checklock
if exist FS0:\EFI\LOCKDOWN.EFI then
  echo " - EFI\LOCKDOWN.EFI      : found"
  goto process
else
  goto missing
endif

:missing
echo "One or more files could not be found. Required:"
echo " - DRIVER\APPLY.EFI"
echo " - DRIVER\8086125B.EFIDRV"
echo " - EFI\BOOT\ZOS.EFI"
echo " - EFI\LOCKDOWN.EFI"
echo ""
echo "Aborting."
exit

goto finished

:process
echo ""
echo "Bootstrap ready, installing"
echo ""

fs0:

echo "Installing SecureBoot Keys"

EFI\LOCKDOWN.EFI


echo "Installing Bootloader"

bcfg boot add 0 \EFI\BOOT\ZOS.EFI "Zero-OS Bootloader"


echo "Installing Driver"

# Awful, I know, but EFI Shell syntax sucks, really.
# Removing any previous driver installed
bcfg driver rm 0 > null
bcfg driver rm 0 > null
bcfg driver rm 0 > null
bcfg driver rm 0 > null

# Installing driver
bcfg driver add 0 \DRIVER\8086125B.EFIDRV SignedNetworkDriver


echo "Starting up Driver Configuration"

\DRIVER\APPLY.EFI

:finished

