/**
 * Noise1D.
 *
 * Using 1D Perlin Noise to assign location.
 part of code from: https://processing.org/examples/noise1d.html
 
 assingment 2.6 making a moveble background 
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 
 */
Flame flame;




void setup() {
  size(360,640);
  //frameRate(10);
  noStroke();

  flame= new Flame();
}

void draw() {
  background(0);
  //fill(0,0,255);
  //rect(0, 0, width, height);
  flame.heightUpdate();
 
}
