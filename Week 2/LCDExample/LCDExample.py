#Clone Git Repository: git clone https://github.com/pimylifeup/Adafruit_Python_CharLCD.git
#CD into Folder: cd Adafruit_Python_CharLCD/
#Install: sudo python3 setup.py install

#!/usr/bin/python
import sys
import Adafruit_DHT
import  time

import Adafruit_CharLCD as LCD 
  
# for GPIO numbering, choose BCM  
lcd_rs = 25
lcd_en = 24
lcd_d4 = 23
lcd_d5 = 17
lcd_d6 = 18
lcd_d7 = 22
lcd_backlight = 2

# Define LCD column and row size for 16x2 LCD.
lcd_columns = 16
lcd_rows = 2

lcd = LCD.Adafruit_CharLCD(lcd_rs, lcd_en, lcd_d4, lcd_d5, lcd_d6, lcd_d7, lcd_columns, lcd_rows, lcd_backlight)


while True:
    humidity, temperature = Adafruit_DHT.read_retry(11, 4)

    lcd.set_cursor(0, 0)
    lcd.message("Temp: %d C" % temperature)
    lcd.set_cursor(0, 1)
    lcd.message("Humidity: %d %%" % humidity)
    lcd.show_cursor(False)
    time.sleep(60)
    lcd.clear()