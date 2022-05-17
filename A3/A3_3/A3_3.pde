/*
  3.3 rain 
    A ground-up and object oriented version of 3.1
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- CONSTANTS 
int num=2000;
Rain[] rain= new Rain[num];

void setup() {
  size (600, 600);

  for (int i=0; i<rain.length; i++) { //makes a lot of rain drops 
    rain[i]= new Rain(4);
  }
}


void draw() {
  fill(155, 155);
  rect(0, 0, width, height);
  for (int i=0; i<rain.length; i++) {
    rain[i].rain();
    rain[i].rainMovement();
  }
}
