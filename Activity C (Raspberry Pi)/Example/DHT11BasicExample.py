import Adafruit_DHT
import time
import sys

sensor=Adafruit_DHT.DHT11
gpio=17


humidity, temperature = Adafruit_DHT.read_retry(sensor,gpio)

try:
    while True:
        time.sleep(0.5)
        if humidity is not None and temperature is not None:
            print('Temp={0:0.1f}*  Humidity={1:0.1f}%'.format(temperature, humidity))

        else:
            print('Failed to get reading. Try again!')
            sys.exit(1)
    
except KeyboardInterrupt: #Break with CTRL+C
    print ("Cleaning up!")

