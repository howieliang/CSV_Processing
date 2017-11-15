//*********************************************
// CSV Processing
// e1_save_a_csv_file
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
  csvData.addColumn("x");
  csvData.addColumn("y");
  csvData.addColumn("label");
}

void draw() {
  if (b_saveCSV) {
    background(255);
    
    //Create N = 50 rows of data
    for (int i = 0; i < 50; i++) {
      //generate the values in the data 
      float x = random(0, width);
      float y = random(0, height);
      int id = (int) floor(random(0, 10));
      float[] features = { x, y };
      
      //Add the new row of the data
      TableRow newRow = csvData.addRow();
      //save each value as Float
      newRow.setFloat("x", x); 
      newRow.setFloat("y", y);
      newRow.setFloat("label", id);
      
      //draw the data on the Canvas
      drawDataPoint(id, features);
    }
    
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