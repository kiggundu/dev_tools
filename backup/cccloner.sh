#!/bin/bash

set -e

INDEX=0
CONFIG_FILE=backup-config.json

log(){
    logger "Backup: $1"
}

while [[  "$(jq -r ".[$INDEX]" "$CONFIG_FILE")" != null ]]                                     #iterate over the config instances
do
    log "Executing "$(jq -r '. | length' "$CONFIG_FILE")" backup entries..."

    if [[  "$(jq -r ".[$INDEX] | length" "$CONFIG_FILE")" == 3 ]]                              #vaidate number of config params
    then
        echo "Obtaining item["$INDEX"] backup details"
        SRC="$(jq -r ".["$INDEX"] | .srcVolume" "$CONFIG_FILE")"                                               #place config params into variables
        DEST="$(jq -r ".["$INDEX"] | .destVolume" "$CONFIG_FILE")"
        DEST_DEL="$(jq -r ".["$INDEX"] | .syncDeleted" "$CONFIG_FILE")"
        SRC_MOUNT="$( systemctl list-units -t mount | grep "^.*\-${SRC}.mount.*mounted.*" )"    #obtain source mount details

        if [ -n "$SRC_MOUNT" ]; then                                                                  #if src mount details exist
            log "Source found: $SRC_MOUNT"
            DEST_MOUNT="$( systemctl list-units -t mount | grep "^.*\-${DEST}.mount.*mounted.*" )"    #obtain destination mount details
            if [ -n "$DEST_MOUNT" ]; then                                                                  #if dest mount details exist
                log "Destination found: $DEST_MOUNT"
                SRC_MOUNT_PATH="$( echo "$SRC_MOUNT" | grep -o "\/.*$"  )"                                                   #obtain source  mount path
                DEST_MOUNT_PATH="$( echo "$DEST_MOUNT_PATH" | grep -o "\/.*$")"                              #obtain source  mount path
                echo "backing up from $SRC_MOUNT_PATH to $DEST_MOUNT_PATH"
                ##if destination mount details exist
                ##grep out the src and dest mounted volume paths
                ##send notification that sync is begining and volumes should not be unplugged
                ##rsync the folders
                ##send notification that volume sync is complete
            else
                log "Waiting for destination [$DEST] ..."
            fi

        else
            log "Waiting for source [$SRC] ..."
        fi
    else
        log "ERROR: Invalid config entry $(jq -r ".[$INDEX]" "$CONFIG_FILE")" =
    fi
    INDEX=$((INDEX+1))
done

