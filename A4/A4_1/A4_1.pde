/*
  3.1 
    A particle generator test
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- GLOBALS 
long millisNextLog = 0;
ParticleSource source; 

// -- INIT 
void setup(){
   size(900,900,P2D);
   source = new ParticleSource(new PVector(width/2,height/2));
}


// -- Every Frame
void draw(){
  background(255);
  
  source.spawn(10);
  source.update();
  source.display();
  
  if(millisNextLog < millis()){
    millisNextLog = millis() + 1000;
    source.logParticleCount();
  } 
}
