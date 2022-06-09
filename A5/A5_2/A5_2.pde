/*
  Flocking
 Sample text
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

// -- GLOBALS

SimObjectContainer fishContainer;
PVector mousePos;
color[] teamColors = {0xFFFFFFFF, 0xFFFF0000, 0xFFFFFF00, 0xFF0000FF, 0xFF00FF00};
int currentTeam = 0;
Obstruction obstruction;

// -- INIT
void setup() {
  size(1000, 1000, P2D);
  fishContainer = new SimObjectContainer();
  fishContainer.spawnFish(100);
  mousePos = new PVector(0, 0);
  obstruction = new Obstruction(mousePos.copy(), random(5, 12));
  fishContainer.addObject(obstruction);
  PShape fishModel = makeFishModel();
}


// -- Every Frame
void draw() {
  background(50);
  fishContainer.update();
  fishContainer.display();
}

void keyPressed() {
  if (key == ' ') {
    currentTeam = (currentTeam + 1) % teamColors.length;
  }
  if ( key == 'q') {
    obstruction.scale(2f);
    obstruction = new Obstruction(mousePos, random(5, 12));
    fishContainer.addObject(obstruction);
  }
}

void mouseMoved() {

  mousePos.x = mouseX;
  mousePos.y = mouseY;

  obstruction.position = mousePos.copy();
}
void mouseDragged() {
  mousePos.x = mouseX;
  mousePos.y = mouseY;

  obstruction.position = mousePos.copy();

  fishContainer.addObject(new Fish(mousePos.copy(), currentTeam, fishContainer.fishForces));
}

PShape makeFishModel(){
  PShape sh = createShape();
  sh.beginShape();
  
  
  sh.endShape();
  
  return sh; 

}
