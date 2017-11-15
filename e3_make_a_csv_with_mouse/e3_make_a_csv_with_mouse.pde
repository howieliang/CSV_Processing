//*********************************************
// CSV Processing
// e3_make_a_csv_with_mouse
// Rong-Hao Liang: r.liang@tue.nl
//*********************************************
// Drag the cursor to make datapoint
// Right click to change label
// S to save the file
// SAVE to clear the current data

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

  if (b_saveCSV) {
    //Save the table to the file folder
    saveTable(csvData, fileName); //save table as CSV file
    println("Saved as: ", fileName);
    //reset b_saveCSV;
    b_saveCSV = false;
  }

  drawMouseCursor(label);
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
    b_saveCSV = true;
  }
  if (key == ' ') {
    csvData.clearRows();
    label = 0;
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