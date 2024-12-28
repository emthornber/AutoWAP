#!/usr/bin/env python3
################################################################################
# gpio_set_pin_value.py
#
# Set a GPIO pin to a value
#
# Usage: gpio_set_pin_value.py [-h] [-d] [-g GPIO_PIN_NUMBER] [-v {off,on}]
#
# optional arguments:
#   -h, --help            show this help message and exit
#   -d, --debug
#   -g GPIO_PIN_NUMBER, --gpio_pin_number GPIO_PIN_NUMBER
#                         (default: 22)
#   -v {off,on}, --gpio_pin_value {off,on}
#                         (default: on)
#
#   28 December, 2024 - E M Thornber
#   Created
#
################################################################################
import atexit
import sys

import pigpio 
import argparse

OFF=0
ON=1
OUTPUT=1

def cleanup():
   pi.stop()

# Initialise Parser
parser = argparse.ArgumentParser(
        prog='gpio_pin_on',
        description='Set a GPIO pin mode to OUTPUT and write pin value')
# Add argument for Pin number.  Default is Pin 22
parser.add_argument('-d', '--debug', action='store_true')
parser.add_argument('-g', '--gpio_pin_number', type=int, default=22, help='(default: %(default)s)')
parser.add_argument('-v', '--gpio_pin_value', choices=['off', 'on'], default='on', help='(default: %(default)s)')
# Parse command line
args = parser.parse_args()
value = ON if args.gpio_pin_value == 'on' else OFF
if args.debug:
    print(args.gpio_pin_number, args.gpio_pin_value, value)

# Initialise PIGPIO library - pigpio daemon is assumed to be running.
pi = pigpio.pi()
if not pi.connected:
    # Problem with daemon ?
    sys.exit(1)

# Clean up on exit
atexit.register(cleanup)

pi.set_mode(args.gpio_pin_number, OUTPUT)
pi.write(args.gpio_pin_number, value)

