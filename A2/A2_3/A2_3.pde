/*
  Template
 Sample text
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

// -- GLOBALS

ArrayList<Dot> dots;

final static float FILL_RATIO_STOP = 0.65; //When this fraction of the screen is filled stop
float SCREEN_SURFACE_AREA;

float fillratio = 0.0;
double failedAttempts = 0;
double attempts = 1;


// -- INIT
void setup() {
  size(1000, 800);
  frameRate(120);

  dots = new ArrayList<Dot>(100);

  SCREEN_SURFACE_AREA = width * height;
}
// -- Creating dots and checking if they are in a valid position
int genDots() {
  // Create dot
  Dot d = new Dot((fillratio * 1.3) + (failedAttempts/attempts * 1.5));
  
  //Check if valid 
  if (d.isValid(dots)) {
    // Get surface area and add it to the ratio
    float surfaceArea = d.getSurfaceArea();
    fillratio += surfaceArea/SCREEN_SURFACE_AREA;
    // Add to array 
    dots.add(d);
    
    // 0 on success 
    return 0;
  }
  // 1 on failure 
  return 1;
}




// -- Every Frame
void draw() {
  background(255);
  
  // Display all dots 
  for (Dot d : dots) {
    d.display();
  }

  // 10 000 attempts per frame  
  for (int i = 0; i < 10000; i++) {
    failedAttempts += genDots();
    attempts++;
    
    //Check for saturation
    if (fillratio > FILL_RATIO_STOP && failedAttempts >= attempts*0.99) {
      noLoop();
      println("DONE");
    }
  }
  
  //println("FILLRATIO: ", fillratio, "Failed: ", failedAttempts/attempts, " Sizeratio: ", fillratio + failedAttempts/attempts);
}
