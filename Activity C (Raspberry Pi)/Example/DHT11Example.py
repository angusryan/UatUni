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
            
            
            humidityString = str(humidity) #convert Humidity float to string
            temperatureString = str(temperature) #convert Temperature float to string
            dataString = temperatureString + " " + humidityString #Concatenate two strings into one
    
    
    
            fb = open('/home/pi/data', 'a+') #Open text file based on assigned directory
            fb.write(dataString) #Write your values temperature and humidity to the text file
            fb.write('\n') #Go to a new line ready for the next value input
            fb.close() #Close to save the new updates to the file

        else:
            print('Failed to get reading. Try again!')
            sys.exit(1)
    
except KeyboardInterrupt: #Break with CTRL+C
    print ("Cleaning up!")
