/*
  3.1 Object Oriented 
    A ground-up and object oriented version of 3.1
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- CONSTANTS 

final static float GRAVITY  = 1.5f; 
final static PVector VA_GRAVITY = new PVector(0,GRAVITY);

final static boolean DELETE_ON_OUT = true; 
final static float PROJ_DENSITY = 0.1;  
final static float FRICTION_MULT = 0.4; 
final static float CATAPULT_SPEED_MULT = 0.4; 


// -- GLOBALS 

Slingshot cat; 
PVector mousePos = new PVector(mouseX,mouseY);


// -- INIT 
void setup(){
  size(800,800);
  cat = new Slingshot(300, height/2);
}


// -- Every Frame
void draw(){
  background(255);
  
  cat.update();
  cat.display();
  

  
  if(mousePressed && PVector.dist(cat.VPos,mousePos) > 40){
    stroke(color(10,10,100));
    strokeWeight(4);
    line(cat.VPos.x,cat.VPos.y, mouseX,mouseY);
    noStroke();
    
    
    fill(color(100,10,10));
    circle(mouseX,mouseY,40);

  }
  
  fill(color(10,100,20));
  circle(cat.VPos.x,cat.VPos.y, 20);

  
} 

// -- Callbacks
void mouseMoved(){
      // This vector is updated andused for spawning the projectiles
  mousePos.x = mouseX;
  mousePos.y = mouseY;
}

void mouseDragged(){
        // This vector is updated andused for spawning the projectiles
  mousePos.x = mouseX;
  mousePos.y = mouseY;
}

void mouseReleased(){
  if(PVector.dist(cat.VPos,mousePos) > 40){
     cat.spawn(mousePos);
  }
}

// -- Misc 
