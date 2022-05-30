/*
  Torch
     An interactible container class for the particle spawer
     
     
   Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

class Torch{
  static final float X_MARGIN = 50; 
  static final float Y_MARGIN = 120;
  static final float SPAWN_Y_OFFSET = -70;
 
  boolean logParticles = true;
  long millisNextLog = 0;
  float noiseTOff;
  
  PVector vPos;
  ParticleSpawner spawner; 
  int PPF;

  Torch(PVector pos, ParticleSpawner spawn, int particlesPerFrame){
    vPos = pos.copy();
    spawner = spawn; 
    PPF = particlesPerFrame; 
    noiseTOff = millis()/ 1000;
  }
  
  void display(){
    // -- Matrix with the position of the torch
    pushMatrix(); 
      colorMode(RGB,255,255,255);
      translate(vPos.x,vPos.y);
      
      //Base 
      stroke(color(200,200,200,150));
      strokeWeight(1);
      fill(color(170,140,30));
      beginShape();
        vertex(-40,-10);
        vertex(40,-10);
        vertex(30,230);
        vertex(-30,230);
      endShape(CLOSE);
      
      //The burning bit 
      noStroke(); 
      fill(color(200,50,40));
       beginShape();
        vertex(-35,-60);
        vertex(35,-60);
        vertex(40,-10);
        vertex(-40,-10);
      endShape(CLOSE);
      
    popMatrix(); //END: Matrix with the position of the torch
    
    // Particles 
    spawner.display();
    
    // Halo 
    noStroke(); 
    fill(color(255,255,120,80));
    circle(vPos.x,vPos.y+SPAWN_Y_OFFSET,300+noise(0,noiseTOff)*100+sqrt(spawner.getParticleCount())*6);
    
    // Particle counter 
    if(logParticles){
        fill(255,255,255);
        textSize(13);
        text("PARTICLES: " + spawner.getParticleCount(), vPos.x+100, vPos.y-200 );
      }
    
    
  }
  void update(){
    spawner.spawn(PPF);
    spawner.update();
    noiseTOff = millis()/ 1000f;
    
    //if(logParticles && millisNextLog < millis()){
    //    millisNextLog = millis() + 1000;
    //    spawner.logParticleCount();
    //} 
  }
  
  void burst(int particleCount){
    spawner.spawn(particleCount);
  }
  
  void move(PVector newPos){
    vPos.x = min(max(newPos.x, 0 + X_MARGIN), width - X_MARGIN);
    vPos.y = min(max(newPos.y, 0 + Y_MARGIN), height - Y_MARGIN);
    
    spawner.setPos(vPos.copy().add(0,SPAWN_Y_OFFSET));
  }
}
