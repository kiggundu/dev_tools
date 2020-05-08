
satr() {
    NAME=$1
    VALUE=$2
    ENTITY=$3

        echo "attr -s \"$NAME\" -V \"$VALUE\" ${ENTITY}'"
    if [ -n "$NAME" ] && [ -n "$VALUE" ] && [ -n "$ENTITY"]
    then
        echo "attr -s \"$NAME\" -V \"$VALUE\" ${ENTITY}'"
    else
        echo "Missing set attribute parameter, Format: satr <name> <value> <entity>"
    fi
}


datr() {
    NAME=$1
    ENTITY=$2

    if [ -n "$NAME" ] && [ -n "$ENTITY" ]
    then
        attr -r "$NAME" ${ENTITY}
    else
        echo "Missing delete attribute parameter, Format: datr <name> <entity>"
    fi
}

gatr() {
    NAME=$1
    ENTITY=$2

    if [ -n "$NAME" ] && [ -n "$ENTITY" ]
    then
        ATTR_VALUE=$(attr -q -g "$NAME" ${ENTITY} 2>/dev/null)
        echo "$ATTR_VALUE"
    else
        echo "bad"
    fi
}

typeset -A unichars
unichars[RED_CIRCLE]=🔴
unichars[PURPLE_HEART]=💜
unichars[ORANGE_HEART]=🧡
unichars[YELLOW_HEART]=💛
unichars[GREEN_HEART]=💚
unichars[BLUE_HEART]=💙
unichars[BLACK_HEART]=🖤

add_emoji_to_line_if_available() {
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
}

latr() {
    ls -al | xargs -L 1 add_emoji_to_line_if_available
}

