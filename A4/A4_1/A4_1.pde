/*
  3.1 
    A particle generator test
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- CONSTANTS 
// Particle constants 
final static float PART_DENSITY = 1;
final static float RADIUS_FALLOFF = 0.97;
final static float FRICTION_COEFF = 0.5;
final static float PART_SATURATION_FALLOFF = 0.96;
final static float PART_BRIGHTNESS_FALLOFF = 0.96;


// Spawner constants 
final static float SPAWN_DISTANCE = 100;
final static float SPAWN_SPEED_MIN = 5;
final static float SPAWN_SPEED_MAX = 10;
final static float SPAWN_ACCELERATION_MIN = 0.001;
final static float SPAWN_ACCELERATION_MAX = 0.015;
final static float SPAWN_ROT_VEL_FACTOR = 0.1;
final static float SPAWN_RADIUS_MIN = 10;
final static float SPAWN_RADIUS_MAX = 30;
final static PVector GRAVITY = new PVector(0,-1f);


// -- GLOBALS 

Torch torch;


// -- INIT 
void setup(){
   size(900,900,P2D);
   ParticleSpawner source = new ParticleSpawner(new PVector(width/2,height/2));
   torch = new Torch(new PVector(width/2,height/2), source , 15);
}


// -- Every Frame
void draw(){
  background(80);
  
  torch.update();
  torch.display();
  
  // Display framerate
  textSize(20);
  text("FPS: " + frameRate , 20, 20);
 
}

// Move the torch on any mouse movement
void mouseMoved(){
  torch.move(new PVector(mouseX,mouseY));
}
void mouseDragged(){
  torch.move(new PVector(mouseX,mouseY));
}

// Burst on mouse click 
void mousePressed(){
  torch.burst(2000);
}
