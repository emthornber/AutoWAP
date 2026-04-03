#!/usr/bin/env python3
################################################################################
# libgpiod_set_pin_value.py
#
# Set a GPIO pin to a value
#
# Usage: libgpiod_set_pin_value.py [-h] [-d] [-g GPIO_PIN_NUMBER] [-v {off,on}]
#
# optional arguments:
#   -h, --help            show this help message and exit
#   -d, --debug
#   -g GPIO_PIN_NUMBER, --gpio_pin_number GPIO_PIN_NUMBER
#                         (default: 22)
#   -v {off,on}, --gpio_pin_value {off,on}
#                         (default: on)
#
#   01 February, 2026 - E M Thornber
#   Created from gpio_set_pin_value.py to use libgpiod instead of pigpio.
#
#   3 April, 2026 - E M Thornber
#   Updated with code from toggle_line_value.py in libgpiod bindings/python/examples
#
#   Note: The libgpiod library has been amended for PiOS to make GPIO pin output
#   states persistent.
#
################################################################################
import argparse

import gpiod
from gpiod.line import Direction, Value

OFF=0
ON=1
OUTPUT=1

# Initialise Parser
def parse_command_line():
    parser = argparse.ArgumentParser(
            prog='libgpiod_set_pin_value',
            description='Set a GPIO pin mode to OUTPUT and write pin value')
    parser.add_argument('-d', '--debug', action='store_true')
    parser.add_argument('-g', '--gpio_pin_number', type=int, default=22, help='(default: %(default)s)')
    parser.add_argument('-v', '--gpio_pin_value', choices=['off', 'on'], default='on', help='(default: %(default)s)')
    args = parser.parse_args()
    if args.debug:
        print(args.gpio_pin_number, args.gpio_pin_value)
    return args
 
# Convert 'on' or 'off' to Value.ACTIVE or Value.INACTIVE
def translate_pin_value(toggle):
    if toggle == 'on':
        return Value.ACTIVE
    return Value.INACTIVE

def set_line_value(chip_path, line_offset, line_value):
    with gpiod.request_lines(
        chip_path,
        consumer='libgpiod_set_pin_value',
        config={
            line_offset: gpiod.LineSettings(
                direction=Direction.OUTPUT, output_value=line_value
            )
        },
    ) as request:
        request.set_value(line_offset, line_value)

if __name__ == "__main__":
    try:
        args = parse_command_line()

        set_line_value('/dev/gpiochip0', args.gpio_pin_number, translate_pin_value(args.gpio_pin_value))
    except OSError as e:
        print(e, "\ncheck the GPIO pin number and that you have permission to access the GPIO chip")
