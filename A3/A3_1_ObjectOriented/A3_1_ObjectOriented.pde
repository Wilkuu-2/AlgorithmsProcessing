/*
  3.1
    A projectile with a constant force, gravity and friction applied to it
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- CONSTANTS

final static float GRAVITY  = 1.5f; 
final static PVector VA_GRAVITY = new PVector(0,GRAVITY);

final static boolean DELETE_ON_OUT = true; 
final static float PROJ_DENSITY = 0.01;  
final static float FRICTION_MULT = 0.01; 
final static int TRACE_MODULO = 5;

final static PVector CONSTANT_FORCE = new PVector(10f,-20f);


// -- GLOBALS 

Projectile proj;



// -- INIT 
void setup(){
  size(800,800,P2D);
  proj = new Projectile(new PVector(200,height-400), new PVector(10,-30), 30, true, true);
}


// -- Every Frame
void draw(){
  background(255);
  
  proj.applyForce(CONSTANT_FORCE);
  proj.update();
  proj.display();
  
  
  if(proj.deleteMe)
    noLoop();
 
}
