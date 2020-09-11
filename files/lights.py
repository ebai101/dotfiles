#!/usr/bin/env python3
import paho.mqtt.client as mqtt
import paho.mqtt.publish as publish
import argparse
from sys import exit

SERVER = '192.168.1.105'
TOPICS = ('light/cmnd/back/', 'light/cmnd/left/', 'light/cmnd/right/', 'light/cmnd/bed/')
PRESETS = {
    'day':  ( '0,0,0,0,255', '0,0,0,0,255', '0,0,0,0,255', '0,0,0,0,255' ),
    'eve':  ( '168,67,0,0,0', '255,149,0,0,0', '255,170,0,0,0', '255,31,162,0,0' ),
    'nite': ( '82,37,189,0,0', '183,0,255,0,0', '165,20,255,0,0', '184,87,7,0,0' )
}

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('command', type=str)
    args = parser.parse_args()
    msg_arr = []

    if args.command == 'on':
        msg_arr = [(t + 'power', 'on', 0, False) for t in TOPICS]
    elif args.command == 'off':
        msg_arr = [(t + 'power', 'off', 0, False) for t in TOPICS]
    elif args.command == 'day':
        msg_arr = [(TOPICS[n] + 'color', PRESETS['day'][n], 0, False) for n in range(len(TOPICS))]
    elif args.command == 'eve':
        msg_arr = [(TOPICS[n] + 'color', PRESETS['eve'][n], 0, False) for n in range(len(TOPICS))]
    elif args.command == 'nite':
        msg_arr = [(TOPICS[n] + 'color', PRESETS['nite'][n], 0, False) for n in range(len(TOPICS))]
    else:
        print('invalid light command:', args.command)
        exit(1)

    try:
        publish.multiple(msg_arr, hostname=SERVER, protocol=mqtt.MQTTv311)
    except Exception as e:
        print('light command failed:', e)
