#!/usr/bin/env python3

import json

with open('bce_freq.json', 'r') as f:
    data = json.load(f)

maxtitle = ''
max = 0
for d in data:
    num = data[d]
    if (max < num):
        max = num
        maxtitle = d
print(maxtitle)
print(max)
