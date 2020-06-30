#!/usr/bin/env bash

file="/Users/ethan/Library/Mobile Documents/com~apple~TextEdit/Documents/todo.txt"
datestamp=$(date +"%D")
[[ $(head -1 "$file") == "TODO $datestamp" ]] || (echo TODO $datestamp\n\n$(cat $file) > "$file")
vim "$file"
