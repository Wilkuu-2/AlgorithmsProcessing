/*
  Particle 
    A simple particle
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

class Particle{
  PVector vPos;
  PVector vVel;
  PVector vAcc; 
  float   rot;
  float   rotVel; 
  float   radius;
  float   frictionCoeff; 
  color   partColor;
  
  boolean deleteMe = false; 
  
  PVector[] vertices;  
  
  // -- Constructor
  Particle(PVector pos, PVector vel, PVector acc, float rot, float rotVel, float rad,color col){
    vPos = pos.copy();
    vVel = vel.copy();
    vAcc = acc.copy();
    this.radius = rad;
    this.rot    = rot; 
    this.rotVel = rotVel;
    partColor = col; 
    
    
    // Model generation 
    vertices = new PVector[4];
    
    vertices[0] = new PVector(random(-1,0),random(-1,0));
    vertices[1] = new PVector(random( 1,0),random(-1,0));
    vertices[2] = new PVector(random( 1,0),random( 1,0));
    vertices[3] = new PVector(random(-1,0),random( 1,0));
  }
  
  void update(){
    
    // -- Physics 
    vVel.add(vAcc); //Constant acceleration 
    
    vVel.sub(vVel.copy().mult(vVel.mag()).mult(FRICTION_COEFF).div(pow(radius,2) * PI * PART_DENSITY)); //Friction
    
    vPos.add(vVel); // Speed 
    
    radius *= RADIUS_FALLOFF; // Particle becomes smaller the longer it lives
    colorMode(HSB, 360, 100, 100);
    partColor = color(hue(partColor),saturation(partColor)*PART_SATURATION_FALLOFF,brightness(partColor)*PART_BRIGHTNESS_FALLOFF);
    
    deleteMe = deleteMe || radius < 1; // Delete particle if radius is less than 1; 
    deleteMe = deleteMe || vPos.x > width || vPos.x < 0 || vPos.y > height || vPos.y < 0; //Delete particle if it's out of bounds 
    
    rot = (rot + rotVel) % TWO_PI; // Rotation
  }
  
  void display(){
    pushMatrix();
      translate(vPos.x,vPos.y);
      rotate(rot); 
      noStroke();
      fill(partColor);
      beginShape();
        for(int i = 0; i < 4; i++)
          putVertex(i);
      endShape(QUAD);
      
    popMatrix();
    
  }
  
  void putVertex(int v){
    PVector vert = vertices[v].copy().mult(radius);
    vertex(vert.x,vert.y);
  }
  
  
}
