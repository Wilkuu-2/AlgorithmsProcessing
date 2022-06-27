/*
 Particle
 A core for the implementation of relatively simple particles
 This includes:
 Density related to radius
 Friction,
 Acceleration,
 Forces with mass
 
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

abstract class Particle {
  float FRICTION_COEFF = 0.1f;
  float PART_DENSITY = 0.1f;
  float RADIUS_FALLOFF = 1.003f;
  float OPACITY_FALLOFF = 0.997f;
  float ROT_FRICTION    = 0f;

  // -- State
  // Vectiors 
  PVector vPos;
  PVector vVel;
  PVector vAcc;
  PVector vForce;
  
  //Rotation
  float   rot;
  float   rVel;
  // Misc
  float   radius;
  float   mass;
  color   partColor;
  // Deletion flag 
  boolean deleteMe = false;



  // -- Constructor
  Particle(PVector pos, PVector vel, PVector acc, float rad, float rot, float rVel, color col) {
    vPos = pos.copy();
    vVel = vel.copy();
    vAcc = acc.copy();
    vForce = new PVector(0, 0);
    this.radius = rad;
    this.rVel   = rVel;
    this.rot    = rot;
    partColor = col;
    // Determine mass using density
    mass = PI*pow(rad, 2) * PART_DENSITY;
  }

  void update(PVector boundPos, PVector boundSize) {
    // -- Physics
    vVel.add(vAcc); //Constant acceleration
    
    vVel.sub(vVel.copy().mult(vVel.mag())
      .mult(FRICTION_COEFF)
      .div(pow(radius, 2) * PI * PART_DENSITY)); //Friction

    // Rotation
    rVel -= rVel * ROT_FRICTION;
    rot += rVel;
    
    // Apply forces 
    vVel.add(vForce.div(mass));
    
    // Bounce 
    PVector relPos = PVector.sub(vPos, boundPos);
    if (relPos.x < 0)
      vVel.x = abs(vVel.x);
    if (relPos.y < 0)
      vVel.y = abs(vVel.y);
    if (relPos.x > boundSize.x)
      vVel.x = -abs(vVel.x);
    if (relPos.y > boundSize.y)
      vVel.y = -abs(vVel.y);


    vPos.add(vVel); // Apply speed 

    radius *= RADIUS_FALLOFF; // Particle becomes bigger the longer it lives
    mass = PI*pow(radius, 2) * PART_DENSITY;
    
    // Lower opacity of the particle 
    partColor = color(red(partColor), green(partColor), blue(partColor), alpha(partColor) * OPACITY_FALLOFF);

    deleteMe = deleteMe || radius < 0.01f; // Delete particle if radius is less than 1;
    update2(); // Additional update handle for the particle subclasses 
  }

  void update2() {}        // Handle for custom state update 
  abstract void display(); // Handle to display the particle 

  // -- Getters 
  PVector getPosition() {
    return vPos.copy();
  }
  PVector getVelocity() {
    return vVel.copy();
  }
  float getRadius() {
    return radius;
  }
  float getMass() {
    return mass;
  }
  
  // Applies force for the duration of the frame
  void applyForce(PVector f) {
    vVel.add(f.div(mass));
  }
  // Applies force permanently 
  void applyConstantForce(PVector f) {
    vForce.add(f);
  }
}
