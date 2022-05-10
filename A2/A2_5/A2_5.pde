/**
 * Noise1D.
 *
 * Using 1D Perlin Noise to assign location.
 part of code from: https://processing.org/examples/noise1d.html
 
   assingment 2.5 making the creature move up, down, right and left  
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
 
 */

PVector v1;
float xVector, yVector;

float xincrement = 0.01;// change the yincrement to an other variable so that the ellipse dosnt just go diagnal
float yincrement = 0.02;

void setup() {
  size(640, 360);
  background(0);
  noStroke();
}

void draw() {
  // creates a vector 
  v1 = new PVector(noise(xVector)*width, noise(yVector)*height);
  fill(0, 10);
  rect(0, 0, width, height);
  //adding increment so the value changes 
  xVector += xincrement;
  yVector += yincrement;
  // Draw the ellipse at the value produced by perlin noise
  fill(200);
  ellipse(v1.x, v1.y, 64, 64);
 
}
