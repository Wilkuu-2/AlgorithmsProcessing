/*
  Flocking 
    An example of flocking
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- GLOBALS 

Swarm s;
PVector mPos; 
color[] colors = {color(255,100,100), color(100,255,100)};
int currentColor = 0; 

// -- INIT 
void setup(){
   s = new Swarm();
   size(800,800);
   s.addUnits(100);
   mPos = new PVector(mouseX,mouseY);
}


// -- Every Frame
void draw(){
  background(200);
  s.run();
  
  fill(colors[currentColor]);
  circle(mPos.x,mPos.y,5);
}

void mouseDragged(){
  s.addUnit(new Unit(mouseX,mouseY, currentColor));
  mPos.x = mouseX;
  mPos.y = mouseY;
}

void mouseMoved(){
 mPos.x = mouseX;
 mPos.y = mouseY;
}

void keyPressed(){
  currentColor = currentColor + 1 % colors.length;
}
