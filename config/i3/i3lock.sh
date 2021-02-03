#!/bin/bash

IMG=/tmp/i3lock.png
SCROT="scrot $IMG"
BLUR="0x8"

$SCROT
convert $IMG -blur $BLUR $IMG
i3lock -i $IMG
rm $IMG
