#############################################
# this script will download all torrents in files.txt that
# are in-progress, not completed and not  already in the library
# it is specific to the kiwix zim files but can be customized
# for use with other torrent batches
###################################################

cleanse_files_list () {
    sed -i 's/\/home\/utorrent\/torrents\/complete\///g' $1
    sed -i 's/_2.*//g' $1
}

#systemctl stop utserver.service

#obtain all known completed downloads and completed torrent files
ls -1 /home/utorrent/torrents/complete/ > completed_downloads.txt
cleanse_files_list completed_downloads.txt
ls -1 /home/utorrent/torrents/complete-torrent-files/ > completed_torrent_files.txt
cleanse_files_list completed_torrent_files.txt
#obtain all folders in the complete downloads that are empty
find /home/utorrent/torrents/complete/ -type d -empty > empty_completed_download_folders.txt
cleanse_files_list empty_completed_download_folders.txt

#Clean up the empty_completed_download_folders by removing those that exist on the mount
ls -1 /mnt/ab4468ad-bd0a-4b49-9bd1-73cf84ca22c5/torrents/complete/ > completed_on_mnt.txt
grep -F -f empty_completed_download_folders.txt completed_on_mnt.txt > empty_completed_download_folders_existing_on_mnt.txt
#delete those folders in the completed directory
#cat empty_completed_download_folders_existing_on_mnt.txt | sudo rm -rf

#obtain all of these that do not have in progress .torrent files
#ls -1 /home/utorrent/torrents/incomplete/*.torrent > incomplete_torrent_files.txt
#sed -i 's/\/home\/utorrent\/torrents\/incomplete\///g' incomplete_torrent_files.txt
#sed -i 's/_2.*//g' incomplete_torrent_files.txt
#grep -F -f incomplete_torrent_files.txt -v files-1.txt > files-2.txt

#obtain all of these that are not in the library
#ls -1 /media/god/Library/kiwix/*.zim > library.txt
#sed -i 's/\/media\/god\/Library\/kiwix\///g' library.txt
#sed -i 's/_2.*//g' library.txt
#grep -F -f library.txt -v files-2.txt > files-3.txt

#Obtain the relevant complete torrent file and place them in the autoload folder making sure they are accessible by utorrent account
ls -1 /home/utorrent/torrents/complete-torrent-files/*.torrent > complete_torrent_files.txt
grep -F -f empty_completed_download_folders.txt complete_torrent_files.txt > torrent_files_for_empty_folders.txt

#Copy those torrents to the autoload folder
 sudo -u utorrent xargs -a torrent_files_for_empty_folders.txt -L 1 -I {} cp {} /home/utorrent/torrents/autoload-torrents/

#copy all complete torrents to the mount and remove them afterwards.
#Need to be careful that the mount files are not owned by utorrent thus doing it in two lines
#This has been fixed now... the complete dir did not have rw permissions
rsync-move /home/utorrent/torrents/complete/* /mnt/ab4468ad-bd0a-4b49-9bd1-73cf84ca22c5/torrents/complete
#sudo -u utorrent rm -rf /home/utorrent/torrents/complete/


#these are the torrents we need to redownload so add them to autoload
#wget -i files-3.txt

#move the torrent files to the autoload folder
#mv *.torrent /home/utorrent/torrents/autoload-torrents

#systemctl start utserver.service
