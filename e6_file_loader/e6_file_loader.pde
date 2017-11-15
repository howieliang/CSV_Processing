//*********************************************
// CSV Processing
// e6_file_loader
// Rong-Hao Liang: r.liang@tue.nl
//*********************************************

String[] filenames;
int[] labels; 
PImage[] images;

void setup() {
  size(500, 500);

  // get the names of all of the files in the "train" folder
  java.io.File folder = new java.io.File(dataPath("train"));
  filenames = folder.list();
  // setup labels and images array for each file
  labels = new int[filenames.length];
  images = new PImage[filenames.length];
  // load in the labels based on the first part of filenames
  for (int i = 0; i < filenames.length; i++) {
    String labelChar = split(filenames[i], '-')[0];
    if (labelChar.equals("A") || labelChar.equals("B") || labelChar.equals("C")) {
      images[i] = loadImage("train/" + filenames[i]);
      images[i].resize(50, 50);
      if (labelChar.equals("A")) {
        labels[i] = 1;
      } else if (labelChar.equals("B")) {
        labels[i] = 2;
      } else if (labelChar.equals("C")) {
        labels[i] = 3;
      }
    } else {
      images[i] = new PImage(50, 50);
      labels[i] = 0;
    }
    println("loading:", filenames[i], "label:", labels[i]);
  }
}

void draw() {
  background(255);
  for (int i = 0; i < images.length; i++) {
    float imgX = (i%10)*50;
    float imgY = (i/10)*50;
    pushStyle();
    image(images[i], imgX, imgY);
    fill(255);
    textSize(12);
    textAlign(CENTER,CENTER);
    text(labels[i], imgX+40, imgY+40);
    popStyle();
  }
  noLoop();
}