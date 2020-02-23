#############################################
# this script will download all torrents in files.txt that
# are in-progress, not completed and not  already in the library
# it is specific to the kiwix zim files but can be customized
# for use with other torrent batches
###################################################


systemctl stop utserver.service

#obtain all known torrents that are not completed zims
ls -1 /home/utorrent/torrents/complete/*.zim > completed_zim_files.txt
sed -i 's/\/home\/utorrent\/torrents\/complete\///g' completed_zim_files.txt
sed -i 's/_2.*//g' completed_zim_files.txt
grep -F -f completed_zim_files.txt -v files.txt > files-1.txt

#obtain all of these that do not have in progress .torrent files
ls -1 /home/utorrent/torrents/incomplete/*.torrent > incomplete_torrent_files.txt
sed -i 's/\/home\/utorrent\/torrents\/incomplete\///g' incomplete_torrent_files.txt
sed -i 's/_2.*//g' incomplete_torrent_files.txt
grep -F -f incomplete_torrent_files.txt -v files-1.txt > files-2.txt

#obtain all of these that are not in the library
ls -1 /media/god/Library/kiwix/*.zim > library.txt
sed -i 's/\/media\/god\/Library\/kiwix\///g' library.txt
sed -i 's/_2.*//g' library.txt
grep -F -f library.txt -v files-2.txt > files-3.txt

#these are the torrents we need to redownload so add them to autoload
wget -i files-3.txt

#move the torrent files to the autoload folder
mv *.torrent /home/utorrent/torrents/autoload-torrents

systemctl start utserver.service
