/**
 * Noise1D.
 *
 * Using 1D Perlin Noise to assign location.
 part of code from: https://processing.org/examples/noise1d.html
 
 assingment 2.5 making the creature move up, down, right and left
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 
 */
Landscape land;




void setup() {
  size(640, 360);
  
  noStroke();

  land= new Landscape();
}

void draw() {
  fill(0,0,255, 100);
  rect(0, 0, width, height);
  land.heightUpdate();
  land.carModdle();
}
