
/*
  5_1 
    flock of fishes 
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/
Flock flock;

void setup() {
  size(1000,1000);
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 150; i++) {
    flock.addBoid(new Boid(random(-width/4,width/4),random(-height/4,height/4)));// spawns them at this location 
  }
}

void draw() {
  translate(width/2,height/2);// placed so that it will help the fishes to stay in the circle border 
  // if you choose to make a rectangle you will have to change the spawn point of the Boid 
  // and the mouse press
    background(50);


  flock.run();
}

// Add a new boid into the System
void mouseDragged() {
  flock.addBoid(new Boid(mouseX-width/2,mouseY-height/2));

}
void mousePressed() {
  flock.addBoid(new Boid(mouseX-width/2,mouseY-height/2));
 
}
