import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)

TRIG1 = 18
ECHO1 = 24

#print ("Distance Measurement in Process")

GPIO.setup(TRIG1,GPIO.OUT)
GPIO.setup(ECHO1,GPIO.IN)

try:
    while True:
        GPIO.output(TRIG1, False)
        #print ("Waiting for Sensor to Settle")
        time.sleep(0.1)
        
        GPIO.output(TRIG1, True)
        time.sleep(0.00001)
        GPIO.output(TRIG1, False)

        while GPIO.input(ECHO1) == 0:
            pulse_start1 = time.time()

        while GPIO.input(ECHO1) == 1:
            pulse_end1 = time.time()
    
        pulse_duration1 = pulse_end1 - pulse_start1
        
        distance1 = pulse_duration1 * 17150
        
        distance1 = round(distance1, 2)
        
        print ("Distance:",distance1, "cm")

except KeyboardInterrupt: #Break with CTRL+C
    print ("Cleaning up!")
    GPIO.cleanup()