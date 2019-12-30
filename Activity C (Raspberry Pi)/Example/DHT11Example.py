#!/usr/bin/python
import sys
import Adafruit_DHT

while True:

    humidity, temperature = Adafruit_DHT.read_retry(11, 4) #Calls the Library which fetches the Humidity and Temperature values and assigns them to variables.
    
    humidityString = str(humidity) #convert Humidity float to string
    temperatureString = str(temperature) #convert Temperature float to string
    dataString = temperatureString + " " + humidityString #Concatenate two strings into one
    
    print('Temp: {0:0.1f} C  Humidity: {1:0.1f} %'.format(temperature, humidity)) #Print values in terminal
    
    fb = open('/home/pi/data', 'a+') #Open text file based on assigned directory
    fb.write(dataString) #Write your values temperature and humidity to the text file
    fb.write('\n') #Go to a new line ready for the next value input
    fb.close() #Close to save the new updates to the file