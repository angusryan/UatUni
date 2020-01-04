import org.gicentre.geomap.*; //<>//
import controlP5.*;

GeoMap geoMap;
ArrayList idList = new ArrayList<String>();
Data data = new Data();
float minSize = 8;
float maxSize = 15;
float maxPop;
ArrayList<Father> fatherArrayList = new ArrayList<Father>();
ArrayList<Mother> motherArrayList = new ArrayList<Mother>();

Slider slider;
ControlP5 cp5;
int total;
Textlabel titleLabel;
Textlabel totalLabel;
Textlabel totalMotherLabel;
Textlabel totalFatherLabel;
Textlabel noBirthLabel;
Textlabel womanLabel;
Textlabel menLabel;
Textlabel noLabel;
Chart myChart;

String filter;
String filterMother;
String filterFather;
int angles [] = new int[2];
int angle [] = new int[1];
color[] c = { #8F0312, #0c4baf, #FFF07E};

int[] greyScale = {0,50,87,167,209,255};

void setup() {
  size(1280, 720);
  geoMap = new GeoMap(this);  // Create the geoMap object.
  geoMap.readFile("world");   // Read shapefile.

  // Set up Slider
  cp5 = new ControlP5(this);
  slider = cp5.addSlider("Year");
  slider.setPosition(50, 600)
    .setSize(200, 20)
    .setRange(1, 8)
    .setNumberOfTickMarks(8)
    .setSliderMode(Slider.FLEXIBLE)
    ;

  // Set up text appearance.
  textAlign(LEFT, BOTTOM);
  textSize(18);

  //geoMap.writeAttributesAsTable(300); //242 total rows

  for (int id : geoMap.getFeatures().keySet())
  {
    // Extract attribute in 3rd column for each ID.
    String currID = geoMap.getAttributeTable().findRow(str(id), 0).getString("NAME");
    idList.add(currID);
  }  

  //read data
  data.loadTables();
  fatherArrayList = data.getFatherList();
  motherArrayList = data.getMotherList();
}

void draw() {
  background(0,0,11);  // Ocean colour (202,226,245)
  stroke(0, 40);              // Boundary colour
  fill(37,134,143);        // Land colour
  geoMap.draw();              // Draw the entire map.

  // Find the country at mouse position and draw in different colour.
  int id = geoMap.getID(mouseX, mouseY);
  //println(mouseX, mouseY);

  // Sldier
  int value = (int)slider.getValue();
  //println(value);

  switch(value) {
  case 1: 
    slider.setValueLabel("2009");
    drawClustersAndLines("2009");
    break;

  case 2:
    slider.setValueLabel("2010");
    drawClustersAndLines("2010");
    break;

  case 3:
    slider.setValueLabel("2011");
    drawClustersAndLines("2011");
    break;

  case 4:
    slider.setValueLabel("2012");
    drawClustersAndLines("2012");
    break;

  case 5:
    slider.setValueLabel("2013");
    drawClustersAndLines("2013");
    break;

  case 6:
    slider.setValueLabel("2014");
    drawClustersAndLines("2014");
    break;

  case 7:
    slider.setValueLabel("2015");
    drawClustersAndLines("2015");
    break;

  case 8:
    slider.setValueLabel("2016");
    drawClustersAndLines("2016");
    break;
  }

  if (id != -1)
  {
    fill(70,196,217); //highlighted colour
    geoMap.draw(id);

    //get associated countries total birth number
    String name = geoMap.getAttributeTable().findRow(str(id), 0).getString("NAME");
    //int total = data.matchFirstSetName(name);

    switch(value) {
    case 1: 
      total = data.matchDataSet(name, 2009);
      drawChartsAndText(name, 2009);
      break;

    case 2:
      total = data.matchDataSet(name, 2010);
      drawChartsAndText(name, 2010);
      break;

    case 3:
      total = data.matchDataSet(name, 2011);
      drawChartsAndText(name, 2011);
      break;

    case 4:
      total = data.matchDataSet(name, 2012);
      drawChartsAndText(name, 2012);
      break;

    case 5:
      total = data.matchDataSet(name, 2013);
      drawChartsAndText(name, 2013);
      break;

    case 6:
      total = data.matchDataSet(name, 2014);
      drawChartsAndText(name, 2014);
      break;

    case 7:
      total = data.matchDataSet(name, 2015);
      drawChartsAndText(name, 2015);
      break;

    case 8:
      total = data.matchDataSet(name, 2016);
      drawChartsAndText(name, 2016);
      break;
    }

    String t = Integer.toString(total);

    if (!t.equals("0") && mouseX < 1150) {
      fill(232, 235, 239);
      text(name + " " + total, mouseX+5, mouseY-5);
    } else if (!t.equals("0") && mouseX > 1150) {
      fill(232, 235, 239);
      text(name + " " + total, mouseX-150, mouseY-5);
    } else if (t.equals("0") && mouseX > 1150) {
      fill(232, 235, 239);
      text(name, mouseX-100, mouseY-5);
    } else {
      fill(232, 235, 239);
      text(name, mouseX+5, mouseY-5);
    }
  }
}

public void drawChartsAndText(String name, int year) {
  // CHARTS AND TEXT FEATURE
  // Variables to get data sets based around mum and dad
  int total = data.matchDataSet(name, year);
  int totalMother = data.getMotherSet(name, year);
  int totalFather = data.getFatherSet(name, year);

  //Parse the data into strings to display in gui
  String t = Integer.toString(total);
  String tm = Integer.toString(totalMother);
  String tf = Integer.toString(totalFather);

  if (t != "0" || tm != "0" || tf != "0") {    
    
    fill(189,195,199); //255
    text(name, mouseX+5, mouseY-5);

    totalFatherLabel = cp5.addTextlabel("label2")
      .setText(tf)
      .setPosition(80, 470)
      .setColorValue(255)
      .setFont(createFont("Helvetica", 15));

    totalMotherLabel = cp5.addTextlabel("label3")
      .setText(tm)
      .setPosition(80, 510)
      .setColorValue(255)
      .setFont(createFont("Helvetica", 15));

    // Unit Conversion
    int totalParents = Integer.parseInt(t);
    int totalMums = Integer.parseInt(tm);
    int totalDads = Integer.parseInt(tf);

    if (totalParents > 0) {
      float mums = round(((float) totalMums / totalParents) * 360); 
      float dads = round(((float) totalDads / totalParents) * 360);

      angles[0] = int(mums);
      angles[1] = int(dads);
      pieChart(100, angles);
    } else {
      // Reset angles to Zero.
      angle[0] = 360;
      //singlePieChart(100, angle);
    }
  }  
}

void pieChart(float diameter, int data[]) {
  float lastAngle = 0;
  for (int i = 0; i < data.length; i++) {
    fill(c[i]);
    arc(100, 500, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
    lastAngle += radians(data[i]);
  }
}

public void drawClustersAndLines(String year) {

  for (int i = 0; i < fatherArrayList.size(); i++) {
    float x = fatherArrayList.get(i).getX();
    float y = fatherArrayList.get(i).getY();

    float pop = 0;

    switch(year){
    case "2009":
      pop = fatherArrayList.get(i).getDataSet2009();
      break;
    case "2010":
      pop = fatherArrayList.get(i).getDataSet2010();
      break;
    case "2011":
      pop = fatherArrayList.get(i).getDataSet2011();
      break;
    case "2012":
      pop = fatherArrayList.get(i).getDataSet2012();
      break;
    case "2013":
      pop = fatherArrayList.get(i).getDataSet2013();
      break;
    case "2014":
      pop = fatherArrayList.get(i).getDataSet2014();
      break;
    case "2015":
      pop = fatherArrayList.get(i).getDataSet2015();
      break;
    case "2016":
      pop = fatherArrayList.get(i).getDataSet2016();
      break;
    }

    if (pop > maxPop) {
      maxPop = pop;
    }

    float normNo = pop/maxPop;
    float lerpVal = lerp(minSize, maxSize, normNo);
    
    
    strokeWeight(normNo * 10);
    
    stroke(255); //i*20%235, i*10%215, i*30%255
    
if (x > 1121 && y > 450){
      noFill();
      curve(x,y,x,y,1121,450,100,200);
    } else if (x > 1121 && y < 450) {
      noFill();
      curve(x,y,x,y,1121,450,600,1000);
    } else if (x < 1121 && y < 300 && x > 850) {
      noFill();
      curve(x,y,x,y,1121,450,i*20,i*50);
    } else if (x < 850 && y < 450 && y > 190) {
      noFill();
      curve(x,y,x,y,1121,450,i*50,i*80);
    } else if (x < 550) {
      noFill();
      curve(x,y,x,y,1121,450,i*20,i*40);
    } else {
      noFill();
      curve(i*30,i*70,x,y,1121,450,1121,450);
    }
    fill(255);
    ellipse(x,y,lerpVal,lerpVal);
  
    //fill(255);
    //ellipse(x, y, lerpVal, lerpVal);
  }
}

void mousePressed() {
  print(mouseX, mouseY);
}
