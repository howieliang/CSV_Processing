//*********************************************
// CSV Processing
// e5_statistical_features
// Rong-Hao Liang: r.liang@tue.nl
//*********************************************
// The papaya library is included in the /code folder.
// Papaya: A Statistics Library for Processing.Org
// http://adilapapaya.com/papayastatistics/

import papaya.*; //statistic library for processing

Table csvData;
String fileName = "data/testData.csv";
boolean b_saveCSV = false;

int label = 0;

void setup() {
  size(500, 500);

  //Initiate the dataList and set the header of table
  csvData = new Table();
  csvData.addColumn("x");
  csvData.addColumn("y");
  csvData.addColumn("label");
}

void draw() {
  background(255);

  for (int i = 0; i < csvData.getRowCount(); i++) { 
    //read the values from the file
    TableRow row = csvData.getRow(i);
    float x = row.getFloat("x");
    float y = row.getFloat("y");
    float id = row.getFloat("label");
    int index = (int) id;

    //form a feature array
    float[] features = { x, y };

    //draw the data on the Canvas
    drawDataPoint(index, features);
  }

  float[] allX = new float[csvData.getRowCount()];
  float[] allY = new float[csvData.getRowCount()]; 
  for (int i = 0; i < csvData.getRowCount(); i++) { 
    //read the values from the file
    TableRow row = csvData.getRow(i);
    float x = row.getFloat("x");
    float y = row.getFloat("y");
    allX[i] = x;
    allY[i] = y;
  }


  if (b_saveCSV) {
    //Save the table to the file folder
    saveTable(csvData, fileName); //save table as CSV file
    println("Saved as: ", fileName);

    //reset b_saveCSV;
    b_saveCSV = false;
  }

  drawMouseCursor(label);

  if (csvData.getRowCount()>0) {
    stroke(0);
    fill(255);
    ellipse(Descriptive.mean(allX), Descriptive.mean(allY), 10, 10);
    noFill();
    stroke(255,0,0);
    ellipse(Descriptive.mean(allX), Descriptive.mean(allY), Descriptive.std(allX, true), Descriptive.std(allY, true));
    rect(Descriptive.min(allX),Descriptive.min(allY),Descriptive.max(allX)-Descriptive.min(allX),Descriptive.max(allY)-Descriptive.min(allY));
  }
  
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    ++label;
    label %= 10;
  }
}

void mouseDragged() {
  //add a row with new data 
  TableRow newRow = csvData.addRow();
  newRow.setFloat("x", mouseX);
  newRow.setFloat("y", mouseY);
  newRow.setFloat("label", label);
}

void keyPressed() {
  if (key == 'S' || key == 's') {
    csvData.clearRows();
    b_saveCSV = true;
  }
}

void drawDataPoint(int _index, float[] _features) {
  pushStyle();
  textSize(12);
  textAlign(CENTER, CENTER);

  stroke(0);
  fill(255);
  ellipse(_features[0], _features[1], 20, 20);

  noStroke();
  fill(0);
  text(_index, _features[0], _features[1]);

  popStyle();
}

void drawMouseCursor(int _index) {
  pushStyle();
  textSize(12);
  textAlign(CENTER, CENTER);
  if (mousePressed) {
    stroke(0);
    fill(255);
  } else { 
    noStroke();
    fill(0);
  }
  ellipse(mouseX, mouseY, 20, 20);

  if (mousePressed) {
    noStroke();
    fill(0);
  } else { 
    fill(255);
  }
  text(_index, mouseX, mouseY);

  popStyle();
}