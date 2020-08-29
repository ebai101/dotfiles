#!/usr/bin/env python3
import paho.mqtt.client as mqtt
import paho.mqtt.publish as publish
import argparse

SERVER='192.168.1.105'
msg_arr = []

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('command', type=str)
    args = parser.parse_args()

    if args.command == 'on':
        msg_arr.append({'topic': 'light/cmnd/back/power',   'payload': 'on'})
        msg_arr.append({'topic': 'light/cmnd/left/power',   'payload': 'on'})
        msg_arr.append({'topic': 'light/cmnd/right/power',  'payload': 'on'})
        msg_arr.append({'topic': 'light/cmnd/bed/power',    'payload': 'on'})
    elif args.command == 'off':
        msg_arr.append({'topic': 'light/cmnd/back/power',   'payload': 'off'})
        msg_arr.append({'topic': 'light/cmnd/left/power',   'payload': 'off'})
        msg_arr.append({'topic': 'light/cmnd/right/power',  'payload': 'off'})
        msg_arr.append({'topic': 'light/cmnd/bed/power',    'payload': 'off'})
    elif args.command == 'day':
        msg_arr.append({'topic': 'light/cmnd/back/color',   'payload': '0,0,0,0,255'})
        msg_arr.append({'topic': 'light/cmnd/left/color',   'payload': '0,0,0,0,255'})
        msg_arr.append({'topic': 'light/cmnd/right/color',  'payload': '0,0,0,0,255'})
        msg_arr.append({'topic': 'light/cmnd/bed/color',    'payload': '0,0,0,0,255'})
    elif args.command == 'eve':
        msg_arr.append({'topic': 'light/cmnd/back/color',   'payload': '168,67,0,0,0'})
        msg_arr.append({'topic': 'light/cmnd/left/color',   'payload': '255,149,0,0,0'})
        msg_arr.append({'topic': 'light/cmnd/right/color',  'payload': '255,170,0,0,0'})
        msg_arr.append({'topic': 'light/cmnd/bed/color',    'payload': '255,31,162,0,0'})
    elif args.command == 'nite':
        msg_arr.append({'topic': 'light/cmnd/back/color',   'payload': '82,37,189,0,0'})
        msg_arr.append({'topic': 'light/cmnd/left/color',   'payload': '183,0,255,0,0'})
        msg_arr.append({'topic': 'light/cmnd/right/color',  'payload': '165,20,255,0,0'})
        msg_arr.append({'topic': 'light/cmnd/bed/color',    'payload': '184,87,7,0,0'})

    publish.multiple(msg_arr, hostname=SERVER, protocol=mqtt.MQTTv311)
