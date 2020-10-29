FILE_TO_CONVERT=$1

if [ -n "$FILE_TO_CONVERT" ]; then
    DEST_FILE="${FILE_TO_CONVERT}.gif"
    echo "Converting $FILE_TO_CONVERT to $DEST_FILE"
    ffmpeg \
        -i $FILE_TO_CONVERT \
        -r 15 \
        -vf "scale=512:-1,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
        -ss 00:00:03 -to 00:00:06 \
        $DEST_FILE
else
    echo "No file path provided. "
    echo "Usage: convert-video-to-gif.sh <file path to convert>"
fi
