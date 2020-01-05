// Slider: https://www.openprocessing.org/sketch/103317/

Table table;

int colourR= 0;
int colourG= 0;
int colourB= 0;
color c = 0;

float slider_width = 50;
float slider_height = 10;
float posx, posy;
boolean over = false;
boolean locked = false;
float xoff;
float fundo;

void setup() {
  size(500, 500, P2D);
  background(240);
  posx = width/2;
  posy = height/1.3;
  rectMode(CENTER);
  line(posx, posy, posx+100, posy);

  //load table
  table = loadTable("airTemperature.csv", "header");

  println(table.getRowCount() + " total rows in table");

  //get values
  for(TableRow row : table.rows()) {

    String species = row.getString("hash");
    String name = row.getString("temp");

    println(name + " (" + species + ") has an ID of ");
  }
}

void draw() {
  stroke(1);
  fundo = posx;
  background(240);
  line (150, posy, 350, posy);
  //println (posx);
  if (dist(mouseX, mouseY, posx, posy) < slider_height) {
    fill(200);
    over = true;
  }
  else {
    fill(255);
    over = false;
  }

  if (posx < 175) {
  println ("ERRO");
  posx = 175;
  }
  
  if (posx > 325) {
  println ("ERRO");
  posx = 325;
  }
  
  rect(posx, posy, slider_width, slider_height);
  
  TableRow row = table.getRow((int)posx);
  int temp = (int)Float.parseFloat(row.getString("temp"));
  String time = row.getString("hash");
  
  switch (temp) {
   case 25:
     colourR = 52;
     colourG = 115;
     colourB = 250;
     break;
   case 26:
     colourR = 52;
     colourG = 138;
     colourB = 250;
     break;
   case 27:
     colourR = 52;
     colourG = 174;
     colourB = 250;
     break;
   case 28:
     colourR = 52;
     colourG = 250;
     colourB = 148;
     break;
   case 29:
     colourR = 72;
     colourG = 250;
     colourB = 52;
     break;
   case 30:
     colourR = 191;
     colourG = 250;
     colourB = 52;
     break;
   case 31:
     colourR = 247;
     colourG = 250;
     colourB = 52;
     break;
   case 32:
     colourR = 250;
     colourG = 220;
     colourB = 52;
     break;
   case 33:
     colourR = 250;
     colourG = 191;
     colourB = 52;
     break;
   case 34:
     colourR = 250;
     colourG = 151;
     colourB = 52;
     break;
   case 35:
     colourR = 250;
     colourG = 115;
     colourB = 52;
     break;
   case 36:
     colourR = 250;
     colourG = 76;
     colourB = 52;
     break;
   case 37:
     colourR = 219;
     colourG = 66;
     colourB = 46;
     break;
   case 38:
     colourR = 219;
     colourG = 46;
     colourB = 46;
     break;
   case 39:
     colourR = 212;
     colourG = 17;
     colourB = 17;
     break;
   case 40:
     colourR = 138;
     colourG = 1;
     colourB = 1;
     break;
   default:
     colourR = 216;
     colourG = 7;
     colourB = 240;
     break;
  }
  
  c = color(colourR, colourG, colourB);
  fill(c);
  noStroke();
  ellipse(width/2, height/2.5, 200, 200);
  
  textSize(25);
  fill(1);
  text("Time and date: " + time, 10, 30); 
  text("Temperature: " + temp, 10, 60); 
}

void mousePressed() {
  if (over) {
    locked = true;
    xoff = mouseX-posx;
  }
}

void mouseDragged() {
  if (locked) {
    posx = mouseX-xoff;
  }
}

void mouseReleased() {
  locked = false;
}
