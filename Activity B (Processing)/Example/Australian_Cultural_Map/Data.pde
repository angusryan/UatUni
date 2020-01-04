import java.text.NumberFormat; //<>//
import java.util.Locale;

Table motherTable;
Table fatherTable;

int numFather;
int numMother;
String numString;
int numInt;
int firstSetInt;
int secondSetInt;
int thirdSetInt;

Father father;
Mother mother;
ArrayList<Father> fatherList = new ArrayList<Father>();
ArrayList<Mother> motherList = new ArrayList<Mother>();

class Data {

  public void loadTables() {

    motherTable = loadTable("mother.csv", "header");
    fatherTable = loadTable("father.csv", "header");

    for (TableRow row : motherTable.rows()) {
      mother = new Mother();
      String country = row.getString("Country of birth of mother");
      if (!country.equals("Australia") && !country.equals("Oceania and Antarctica") && !country.equals("Total overseas-born") && !country.equals("Total") && !country.equals("North-West Europe") ) {
        mother.setCountry(country);
        mother.setDataSet2009(formatToInt(row.getString("2009"))); 
        mother.setDataSet2010(formatToInt(row.getString("2010"))); 
        mother.setDataSet2011(formatToInt(row.getString("2011"))); 
        mother.setDataSet2012(formatToInt(row.getString("2012"))); 
        mother.setDataSet2013(formatToInt(row.getString("2013"))); 
        mother.setDataSet2014(formatToInt(row.getString("2014"))); 
        mother.setDataSet2015(formatToInt(row.getString("2015"))); 
        mother.setDataSet2016(formatToInt(row.getString("2016"))); 
        mother.setX(row.getFloat("x"));
        mother.setY(row.getFloat("y"));
        motherList.add(mother);
      }
    }

    for (TableRow row : fatherTable.rows()) {
      father = new Father();
      String country = row.getString("Country of birth of father");
      if (!country.equals("Australia") && !country.equals("Oceania and Antarctica") && !country.equals("Total overseas-born") && !country.equals("Total") && !country.equals("North-West Europe") ) {
        father.setCountry(country);
        father.setDataSet2009(formatToInt(row.getString("2009"))); 
        father.setDataSet2010(formatToInt(row.getString("2010"))); 
        father.setDataSet2011(formatToInt(row.getString("2011"))); 
        father.setDataSet2012(formatToInt(row.getString("2012"))); 
        father.setDataSet2013(formatToInt(row.getString("2013"))); 
        father.setDataSet2014(formatToInt(row.getString("2014"))); 
        father.setDataSet2015(formatToInt(row.getString("2015"))); 
        father.setDataSet2016(formatToInt(row.getString("2016"))); 
        father.setX(row.getFloat("x"));
        father.setY(row.getFloat("y"));
        fatherList.add(father);
      }
    }
  }


  public int formatToInt(String set) {
    try {
      Number num = NumberFormat.getNumberInstance(Locale.UK).parse(set);
      return Integer.parseInt(num.toString());
    } 
    catch (Exception e) {
      println(e.getMessage());
    }
    return 0;
  }

  public ArrayList<Father> getFatherList() {
    return fatherList;
  }

  public ArrayList<Mother> getMotherList() {
    return motherList;
  }

  public int matchDataSet(String name, int year) {
    //for (Father _father : fatherList) {
    //  if (_father.getCountry().equals(name)) {
    //    numFather = setNumFather(year, _father);
    //  }
    //}
    //for (Mother _mother : motherList) {
    //  if (_mother.getCountry().equals(name)) {
    //    numMother = setNumMother(year, _mother);
    //    return numFather + numMother;
    //  }
    //}
    //return 0;
    return getMotherSet(name,year) + getFatherSet(name,year);
  }

  public int getFatherSet(String name, int year) {
    for (Father _father : fatherList) {
      if (_father.getCountry().equals(name)) {
        return numFather = setNumFather(year, _father);
      }
    }
    return 0;
  }

  public int getMotherSet(String name, int year) {
    for (Mother _mother : motherList) {
      if (_mother.getCountry().equals(name)) {
        return numMother = setNumMother(year, _mother);
        //return numFather + numMother;
      }
    }
    return 0;
  }


  int setNumFather(int year, Father _father) {
    switch (year) {
    case 2009:
      return _father.getDataSet2009();
    case 2010:
      return _father.getDataSet2010();    
    case 2011:
      return _father.getDataSet2011();
    case 2012:
      return _father.getDataSet2012();
    case 2013:
      return _father.getDataSet2013();
    case 2014:
      return _father.getDataSet2014(); 
    case 2015:
      return _father.getDataSet2015();
    case 2016:
      return _father.getDataSet2016();
    }
    return 0;
  }

  int setNumMother(int year, Mother _mother) {
    switch (year) {
    case 2009:
      return _mother.getDataSet2009();
    case 2010:
      return _mother.getDataSet2010();   
    case 2011:
      return _mother.getDataSet2011();
    case 2012:
      return _mother.getDataSet2012();
    case 2013:
      return _mother.getDataSet2013();
    case 2014:
      return _mother.getDataSet2014();      
    case 2015:
      return _mother.getDataSet2015();
    case 2016:
      return _mother.getDataSet2016();
    }
    return 0;
  }
}
