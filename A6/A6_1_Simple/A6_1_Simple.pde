/*
  Simple rotational Spring-Damper system
 This simple system replicates flowers swinging in the wind, 
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

// -- GLOBALS

SpringElement[][] springs;
static final float timeFactor = 0.0001;
static final int flowerHeight = 30;
float timeParameter = millis() * timeFactor;
long nanosElapsed = System.nanoTime();

// -- INIT
void setup() {
  springs = new SpringElement[50][flowerHeight];
  size(800, 800, P2D);
  for (int i = 0; i < springs.length; i++) {
    for (int j = 0; j < springs[i].length; j++)
      springs[i][j] = new SpringElement(random(-PI/300f, PI/300f), random(-PI/1000f, PI/1000f), j);
  }
  
  noiseDetail(3);
}


// -- Every Frame
void draw() {
  nanosElapsed = System.nanoTime(); // Start counting time 
  // Background
  background(160,180,255);
  noStroke();
  fill(90,200,90);
  rect(0, height*0.90, width , height);
  
  // Update (2d array iter)
  for (int i = 0; i < springs.length; i++) { 
    // First element 
     springs[i][0].update(0, springs[i][1].rForce);
    
    // Middle elements 
    for (int j = 1; j < springs[i].length -1; j++) {
        springs[i][j].update(springs[i][j-1].rVel, springs[i][j+1].rForce); 
    }
    // Last element
    springs[i][springs[i].length-1].update(springs[i][springs[i].length-2].rVel, 0);
  }
 
  timeParameter = millis() * timeFactor;
  // Start drawing  
  pushMatrix(); // ++Loop matrix 
  translate(10,height - 10);
 
  for (int i = 0; i < springs.length; i++){
    pushMatrix(); // ++Single flower matrix 
    translate(width/50f*i,0); // Horizontal placement
    
    for (int j = 0; j < springs[i].length; j++)
      springs[i][j].display();
      
    popMatrix(); // -- Single flower matrix 
  }
  popMatrix(); // -- Loop matrix
  
  // FPS Printing 
  nanosElapsed = System.nanoTime() - nanosElapsed; //Stop counting time
  fill(0);
  text(String.format("FPS: %.5f",    frameRate      ),10 ,10);
  text(String.format("TPF: %.5f ms",  nanosElapsed/1000000f ),10 ,20);
  
}
