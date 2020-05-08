#!/bin/zsh
    # This function
    # - tokenizes a line of text delimited by spaces
    # - assumes the last token is a file/directory
    # - gets the 'default' extension attribute of the file/directory
    # - converts the attribute to the equivalent unicode charachter if possible otherwise leaves it unchanged
    # - Returns the same line prepended with the unicode charachter
    LINE=$1
    FILE=$(grep -o '[^\ ]\+$' <<< "$LINE")

    # A yank of gatr
    NAME="default"
    ENTITY=$FILE
    if [ -n "$NAME" ] && [ -n "$ENTITY" ]
    then
        DEFAULT_ATTR=$(attr -q -g "$NAME" ${ENTITY} 2>/dev/null)
    fi

    if [ -n "$DEFAULT_ATTR" ] && [ -n "$unichars[$DEFAULT_ATTR]" ]
    then
        echo "$unichars[$DEFAULT_ATTR] $LINE"
    else
        echo "$DEFAULT_ATTR $LINE"
    fi

