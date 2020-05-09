#===============================================================================
#
#          FILE: timer.sh
#
#         USAGE: ./timer.sh
#
#   DESCRIPTION: A simple seconds countdown timer
#
#       OPTIONS: takes the start in seconds and counts down to zero
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Abraham Kigundu,
#  ORGANIZATION:
#       CREATED: 05/09/2020 11:52:59 AM
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

overwrite() { echo -e "\r\033[1A\033[0K$@"; }

seconds=$1;
date1=$((`date +%s` + $seconds));
echo "Counting down ${seconds} seconds"
echo "Counting down ${seconds} seconds"
while [ "$date1" -ge `date +%s` ]; do
    overwrite "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)";
done
