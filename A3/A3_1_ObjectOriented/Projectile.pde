/*
  Projectile 
    A round 2D ridgid body with mass that simulates: 
      Air Resistance 
      Gravity 
      Other Forces
    
    You can spawn it with a custom position, speed, and radius, the mass is determined by global density. 
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/



class Projectile{
  PVector VPos; 
  PVector VSpeed;
  boolean hasGravity;
  boolean hasResistance; 
  boolean deleteMe = false;
  boolean isOOB = false;
  long tics = 0;
  float radius;
  float mass;
  ArrayList<PVector> trace;
  
  // -- Constructor 
  Projectile(PVector initPos, PVector initSpeed, float radius ,boolean hasGravity, boolean hasResistance){
    this.radius = radius;
    mass = PI * pow(radius,2) * PROJ_DENSITY;
    VPos = initPos;
    VSpeed = initSpeed;
    this.hasGravity = hasGravity; 
    this.hasResistance = hasResistance; 
    
    trace = new ArrayList<PVector>();
  }
  
  // -- State Update
  void update(){
    if(!isOOB){ // Do not update if out of bounds 
    PVector VTotalForce = new PVector(0,0);
    // Add gravity to total force
    if(hasGravity);
      VTotalForce.add(VA_GRAVITY.copy().mult(mass)); 
    
    // Add friction to total force 
    if(hasResistance);
      VTotalForce.add(VSpeed.copy().mult(-FRICTION_MULT * radius));
    
    // Add total force divided by mass to speed as acceleration 
    applyForce(VTotalForce);
    
    println("Update: MASS ", mass , "RADIUS " , radius );
    // Add a trace 
    tics ++; 
    if(tics % TRACE_MODULO == 0)
      trace.add(VPos.copy());
    
    // Add speed to position 
    VPos.add(VSpeed);
    
    // Check if out of bounds and if the projectile needs to be deleted from the parent
    isOOB = (VPos.x > width || VPos.y > height || VPos.x < 0 || VPos.y < 0);
    deleteMe = isOOB && DELETE_ON_OUT; 
    }
    
    
    
  }
  
    // Applies force to projectile 
  void applyForce(PVector f){
    VSpeed.add(f.copy().div(mass));
  }
  
  // -- Drawing
  void display(){
    // Original projectile 
    fill(0,0,220);
    noStroke();
    circle(VPos.x, VPos.y, radius*2); 
    
    for(int i = trace.size(); i > 0 ; i--){
      fill(0,0,(i-1) * 220/ trace.size());
      circle(trace.get(i-1).x,trace.get(i-1).y,radius*2);
    }
  }
  
  
}
