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

  PVector vPos;
  PVector vVel;
  PVector vAcc;
  PVector vForce;
  float   radius;
  float   rot;
  float   rVel;
  float   mass;
  color   partColor;

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
    mass = PI*pow(rad, 2) * PART_DENSITY;
  }

  void update(PVector boundPos, PVector boundSize) {
    // -- Physics
    vVel.add(vAcc); //Constant acceleration

    vVel.sub(vVel.copy().mult(vVel.mag())
      .mult(FRICTION_COEFF)
      .div(pow(radius, 2) * PI * PART_DENSITY)); //Friction

    rVel -= rVel * ROT_FRICTION;
    rot += rVel;
    vVel.add(vForce.div(mass));

    PVector relPos = PVector.sub(vPos, boundPos);
    if (relPos.x < 0)
      vVel.x = abs(vVel.x);
    if (relPos.y < 0)
      vVel.y = abs(vVel.y);
    if (relPos.x > boundSize.x)
      vVel.x = -abs(vVel.x);
    if (relPos.y > boundSize.y)
      vVel.y = -abs(vVel.y);


    vPos.add(vVel); // Speed

    radius *= RADIUS_FALLOFF; // Particle becomes bigger the longer it lives
    mass = PI*pow(radius, 2) * PART_DENSITY;

    partColor = color(red(partColor), green(partColor), blue(partColor), alpha(partColor) * OPACITY_FALLOFF);

    deleteMe = deleteMe || radius < 0.00001f; // Delete particle if radius is less than 1;
    update2();
  }

  void update2() {
  }
  abstract void display();

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
  void applyForce(PVector f) {
    vVel.add(f.div(mass));
  }
  void applyConstantForce(PVector f) {
    vForce.add(f);
  }
}
