#!/bin/sh
if [ ! -f "/server/folia.jar" ]; then
    /setup/getFolia.sh

    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

while true; do
    java -Xms$MIN_RAM -Xmx$MAX_RAM $JAVA_FLAGS -Dcom.mojang.eula.agree=$MINECRAFT_EULA -jar /server/folia.jar $FOLIA_FLAGS --nogui
    if [ $? -ne 0 ]; then
        exit 1
    fi
done
