
# This script reads the information from the clipboard outloud.

# Look for festival being run.
running=$(pgrep festival)

if [ -z $running ]
then
    # read it
    xclip -o|festival --tts
else
    # kill it
    killall festival;killall aplay;sleep .1;killall aplay
fi
