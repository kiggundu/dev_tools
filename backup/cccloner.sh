#!/bin/bash

INDEX=0
CONFIG_FILE=backup-config.json

while [[  "$(jq -r ".[$INDEX]" "$CONFIG_FILE")" != null ]]
do
    if [[  "$(jq -r ".[$INDEX] | length" "$CONFIG_FILE")" == 3 ]]
    then
        SRC="$(jq -r ".["$INDEX"] | .srcVolume")"
        DEST="$(jq -r ".["$INDEX"] | .destVolume")"
        DEST_DEL="$(jq -r ".["$INDEX"] | .syncDeleted")"
        SRC_MOUNT="$( systemctl list-units -t mount | grep "^.*\-${SRC}.mount.*mounted.*" )"
    else
        echo "need 3 json properties for each backup config"
    fi

    count=$((count+1))
done

while [[  ]]
do
  SRC=$( cut -d'>' -f1 <<< $line )
  DEST=$( cut -d'>' -f2 <<< $line )

  SRC_MOUNT=$( systemctl list-units -t mount | grep "^.*\-${SRC}.mount.*mounted.*" )

  if [ -n "$SRC_MOUNT" ]; then
    echo "Source mount for $SRC exists and is $SRC_MOUNT";

  else
    echo "Source mount for $SRC does not exist";
  fi

done < driveroutes.txt
