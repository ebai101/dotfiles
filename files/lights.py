#!/usr/bin/env python3

import argparse, requests
from sys import exit

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('command', type=str)
    args = parser.parse_args()
    base_url = 'http://192.168.1.105:3000/'

    if args.command == 'get':
        r = requests.get(base_url)
        print(r.text)
    else:
        r = requests.post(base_url + '?' + args.command)
        if r.status_code == 404:
            print('invalid light command:', args.command)
            exit(1)
