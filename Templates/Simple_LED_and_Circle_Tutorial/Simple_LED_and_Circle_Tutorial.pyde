add_library('io')
ledOn = True

# GPIO numbers refer to different phyiscal pins on various boards
# On the Raspberry Pi GPIO 18 is physical pin 5 on the header

def setup():
    size(500,500)
    GPIO.pinMode(18, GPIO.OUTPUT)
    frameRate(0.5)

def draw():
  global ledOn
  # make the LED blink
  ledOn = not ledOn
  if ledOn:
    GPIO.digitalWrite(18, GPIO.LOW)
    fill(204)
  else:
    GPIO.digitalWrite(18, GPIO.HIGH)
    fill(0,0,255)
  stroke(255)
  ellipse(width/2, height/2, width*0.75, height*0.75)
