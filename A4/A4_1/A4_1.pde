/*
  3.1 
    A particle generator test
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- CONSTANTS 
// Particle constants 
final static float PART_DENSITY = 1;
final static float RADIUS_FALLOFF = 0.94;
final static float FRICTION_COEFF = 0.5;


// Spawner constants 
final static float SPAWN_DISTANCE = 100;
final static float SPAWN_SPEED_MIN = 5;
final static float SPAWN_SPEED_MAX = 10;
final static float SPAWN_ACCELERATION_MIN = 0.001;
final static float SPAWN_ACCELERATION_MAX = 0.0015;
final static float SPAWN_ROT_VEL_FACTOR = 0.1;
final static float SPAWN_RADIUS_MIN = 10;
final static float SPAWN_RADIUS_MAX = 30;


// -- GLOBALS 
long millisNextLog = 0;
ParticleSpawner source; 

// -- INIT 
void setup(){
   size(900,900,P2D);
   source = new ParticleSpawner(new PVector(width/2,height/2));
}


// -- Every Frame
void draw(){
  background(255);
  
  source.spawn(15);
  source.update();
  source.display();
  
  if(millisNextLog < millis()){
    millisNextLog = millis() + 1000;
    source.logParticleCount();
  } 
}
