#!/bin/bash

PATH=/usr/local/bin:$PATH

front=$(yabai -m query --windows | jq 'map(select(.focused == 1))[0]')
id=$(echo $front | jq '.id')

case $1 in
    toggle)
        [ $(echo $front | jq '.floating') -eq "0" ] && (
            yabai -m window $id --toggle float
            yabai -m window $id --grid 6:6:1:1:4:4
        ) || (
            yabai -m window $id --toggle float
        )
        ;;
    notoggle)
        yabai -m window $id --grid 6:6:1:1:4:4
    ;;
esac
