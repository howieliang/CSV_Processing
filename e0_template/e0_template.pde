//*********************************************
// CSV Processing
// e0_template
// Rong-Hao Liang: r.liang@tue.nl
//*********************************************

Table csvData;
String fileName = "data/testData.csv";
boolean b_saveCSV = false;

void setup() {
  size(500, 500);
  background(255);
  
  //Initiate the dataList and set the header of table
  csvData = new Table();
}

void draw() {
  //1. update the data here
  //2. visualize something here
  //3. save the data when b_saveCSV is true
  if (b_saveCSV) {
  //Save the table to the file folder
    saveTable(csvData, fileName); //save table as CSV file
    println("Saved as: ", fileName);
    
    //reset b_saveCSV;
    b_saveCSV = false;
  }
    
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