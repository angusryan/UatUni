#!/usr/bin/python
import sys
import Adafruit_DHT

while True:

    humidity, temperature = Adafruit_DHT.read_retry(11, 4)
    humidityString = str(humidity)
    temperatureString = str(temperature)
    dataString = temperatureString + " " + humidityString
    print('Temp: {0:0.1f} C  Humidity: {1:0.1f} %'.format(temperature, humidity))
    fb = open('/home/pi/data', 'a+')
    fb.write(dataString)
    fb.write('\n')
    fb.close()