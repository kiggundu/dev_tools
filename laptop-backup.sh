# Backup app installations
#these can be reinstalled as follows
#sudo apt-clone restore Lenovo_Thinkpad_apps.apt-clone.tar.gz #this tells apt to install the packages n the list.
sudo apt-clone clone --with-dpkg-repack /home/god/Lenovo_Thinkpad_apps

#Recomended backup locations obtained from https://unix.stackexchange.com/a/286714
#First backup the main volume
sudo duplicity \
    --hidden-encrypt-key 8DC39E976CA0DBA89666F4256E7386BE499140CD \
    --progress \
    --include /home \
    --include /etc \
    --include /usr/local \
    --include /opt \
    --include /srv \
    --include /root \
    --include /var/lib \
    --include /var/mail \
    --include /var/www \
    --include /var/backups \
    --exclude '**' \
    /  file:///media/god/Library/god-ThinkPad-P1-backup

#...now backup the shared volumr
sudo duplicity \
    --hidden-encrypt-key 8DC39E976CA0DBA89666F4256E7386BE499140CD \
    --progress \
    /mnt/ab4468ad-bd0a-4b49-9bd1-73cf84ca22c5  file:///media/god/Library/god-ThinkPad-P1-shared_volume-backup

#Restore duplicity backup
# ...first find the file you are looking for
## sudo duplicity list-current-files file:///media/god/Library/god-ThinkPad-P1-backup | grep my/file
# ...then restore it using
## sudo duplicity restore --hidden-encrypt-key 8DC39E976CA0DBA89666F4256E7386BE499140CD --file-to-restore file/to/restore/without/leading/slash  file:///media/god/Library/god-ThinkPad-P1-backup where/to/save/locally

