#!/usr/bin/env python3

import json

with open('bce_freq.json', 'r') as f:
    data = sorted([(k, v) for k, v in json.load(f).items()],
                  key=lambda x: x[1],
                  reverse=True)

print('# | freq | device')
index = 1
for d in data[:50]:
    print(f'{index}: {d[1]}\t- {d[0]}')
    index += 1
