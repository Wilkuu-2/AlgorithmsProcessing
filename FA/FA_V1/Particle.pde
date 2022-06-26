

abstract class Particle{
  float FRICTION_COEFF = 0.1f;
  float PART_DENSITY = 0.1f;
  float RADIUS_FALLOFF = 1.003f;
  float OPACITY_FALLOFF = 0.997f;

  PVector vPos;
  PVector vVel;
  PVector vAcc;
  float   radius;
  float   mass;
  color   partColor;

  boolean deleteMe = false;


  
  // -- Constructor
  Particle(PVector pos, PVector vel, PVector acc, float rad, color col) {
    vPos = pos.copy();
    vVel = vel.copy();
    vAcc = acc.copy();
    this.radius = rad;
    partColor = col;
    mass = PI*pow(rad,2) * PART_DENSITY;
  }

  void update() {
    // -- Physics
    vVel.add(vAcc); //Constant acceleration

    vVel.sub(vVel.copy().mult(vVel.mag())
      .mult(FRICTION_COEFF)
      .div(pow(radius, 2) * PI * PART_DENSITY)); //Friction

    vPos.add(vVel); // Speed

    radius *= RADIUS_FALLOFF; // Particle becomes bigger the longer it lives
    mass = PI*pow(radius,2) * PART_DENSITY;
    
    partColor = color(red(partColor), green(partColor), blue(partColor), alpha(partColor) * OPACITY_FALLOFF);

    deleteMe = deleteMe || radius < 0.1f; // Delete particle if radius is less than 1;
    deleteMe = deleteMe || alpha(partColor) < 10; // Delete particle if radius is less than 1;
    deleteMe = deleteMe || vPos.x > width || vPos.x <0 || vPos.y > height || vPos.y < height *0.16; //Delete particle if it's out of bounds
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
  void applyForce(PVector f){
    vVel.add(f.div(mass));
    
  }
  
  

}
