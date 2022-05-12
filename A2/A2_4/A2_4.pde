/*
  assingment 2.4 useing the Gaussian distribution create a paint splat 
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/


int num=560; // amount of circle you want 
PVector[] location = new PVector[num];
float[] size = new float[num];
float mean=width/2;
void setup() {
  size(800, 800);
}

void draw() {
  noStroke();
  translate(width/2, width/2);
}

void mouseClicked() {
  background(204);
  for (int i = 0; i < num; i++) {
    location[i] = new PVector();
    location[i].y= (int(randomGaussian() * 80)+mean);
    size[i] = int(randomGaussian() * 10);
    location[i].x = (int(randomGaussian() * 80)+mean);
  }

  for (int i = 0; i < location.length; i++) {
    fill(0, 0, 255);
    rotate(TWO_PI/location.length);

    float distX = abs(location[i].x);
    float distY = abs(location[i].y);
    float sizeP = abs(size[i]);
    circle(distX, distY, sizeP);
  }
}
