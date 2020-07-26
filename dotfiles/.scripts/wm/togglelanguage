#!/bin/bash

# start daemon if not already started
ibus-daemon &

# switch to pinyin if currently english, and vice-versa
CURR=$(ibus engine)
DEFAULT="xkb:us::eng"
if [ $CURR = $DEFAULT ]
then
    ibus engine libpinyin
else
    ibus engine $DEFAULT
fi
