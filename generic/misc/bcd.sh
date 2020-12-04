#!/bin/bash




# /boot/efi/EFI contains boot loaders.
# bcdedit and grub-install seems to be managing data beyond that EFI folder,
# both are able to set UEFI firmware settings regarding the needed .efi path.
# Windows is eager but messed the settings.
# BIOS/UEFI errors out and boots from disk's default settings.

# Does chaning .efi path here saves Windows from touching the firmware?
sudo bash -c 'bcdedit /set {bootmgr} path '\''\EFI\ubuntu\grubx64.efi'\'';bcdedit'


