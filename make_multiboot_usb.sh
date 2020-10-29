#Use this as a guide : https://www.pendrivelinux.com/boot-multiple-iso-from-usb-via-grub2-using-linux/)
#Follow these instaructions
#- create a GPT partition table for the USB
#- create a simgle FAT32 partition on the usb and ensure it is an esp (EFI System Partition) and a boot partition.
#- mount it and create two directories 'system' and 'boot'
#- run the following grub nstall command to install EFI system files and grub boot files
sudo grub-install --force --no-floppy --boot-directory=/mnt/USB/boot --efi-directory=/mnt/USB/system /dev/sdc1
