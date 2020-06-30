#!/bin/bash 

PATH=/usr/local/bin:$PATH
appname=$1
window=$(yabai -m query --windows | jq --arg v "$appname" 'map(select(.app == $v))[0]')
if [ "$window" == "null" ]; then
    open -a "$appname"
else
    echo $window | jq '.space' | xargs -I{} yabai -m space --focus {}
    echo $window | jq '.id' | xargs -I{} yabai -m window --focus {}
fi
