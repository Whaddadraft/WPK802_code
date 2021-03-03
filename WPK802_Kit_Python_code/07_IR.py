#!/usr/bin/env python

import RPi.GPIO as GPIO
IrPin = 11
count = 0

def setup():
    GPIO.setmode(GPIO.BOARD) # Numbers GPIOs by physical location
    GPIO.setup(IrPin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

def cnt(ev=None):
    global count
    count += 1
    print("Received infrared. Cnt = ", count)

def loop():
    GPIO.add_event_detect(IrPin, GPIO.FALLING, callback=cnt) # Wait for falling edge on IR pin

    while True:
        pass

def destroy():
    GPIO.cleanup() # Release GPIO resources

if __name__ == "__main__":
    setup()

    try:
        loop()
    except KeyboardInterrupt: # When 'Ctrl+C' is pressed, the destoy() function will be executed
        destroy()