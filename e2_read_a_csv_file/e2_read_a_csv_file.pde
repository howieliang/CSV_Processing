//*********************************************
// CSV Processing
// e2_read_a_csv_file
// Rong-Hao Liang: r.liang@tue.nl
//*********************************************

Table csvData;

void setup() {
  size(500, 500);

  //Initiate the dataList and set the header of table
  csvData = loadTable("testData.csv", "header");
}

void draw() {
  background(255);
  if (csvData != null) {
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
  }
  noLoop();
}

void drawDataPoint(int _index, float[] _features) {
  pushStyle();
  textSize(12);
  textAlign(CENTER, CENTER);
  
  //draw the label with a circle
  stroke(0);
  fill(255);
  ellipse(_features[0], _features[1], 20, 20);
  noStroke();
  fill(0);
  text(_index, _features[0], _features[1]);

  popStyle();
}