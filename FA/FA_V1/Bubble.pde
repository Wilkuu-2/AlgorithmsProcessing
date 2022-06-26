class Bubble {
  final static float FRICTION_COEFF = 0.1f;
  final static float PART_DENSITY = 0.1f;
  final static float RADIUS_FALLOFF = 1.003f;
  final static float OPACITY_FALLOFF = 0.997f;

  PVector vPos;
  PVector vVel;
  PVector vAcc;
  float   radius;
  float   frictionCoeff;
  color   partColor;

  boolean deleteMe = false;

  // -- Constructor
  Bubble(PVector pos, PVector vel, PVector acc, float rad, color col) {
    vPos = pos.copy();
    vVel = vel.copy();
    vAcc = acc.copy();
    this.radius = rad;
    partColor = col;
  }

  void update() {
    // -- Physics
    vVel.add(vAcc); //Constant acceleration

    vVel.sub(vVel.copy().mult(vVel.mag())
      .mult(FRICTION_COEFF)
      .div(pow(radius, 2) * PI * PART_DENSITY)); //Friction

    vPos.add(vVel); // Speed

    radius *= RADIUS_FALLOFF; // Particle becomes bigger the longer it lives
    partColor = color(red(partColor), green(partColor), blue(partColor), alpha(partColor) * OPACITY_FALLOFF);

    deleteMe = deleteMe || radius < 0.1f; // Delete particle if radius is less than 1;
    deleteMe = deleteMe || alpha(partColor) < 10; // Delete particle if radius is less than 1;
    deleteMe = deleteMe || vPos.x > width || vPos.x <0 || vPos.y > height || vPos.y < height *0.16; //Delete particle if it's out of bounds

  }

  void display() {
    // -- Matrix with the position and rotation of the particle
    pushMatrix();
    translate(vPos.x, vPos.y);

    noStroke();
    fill(color(red(partColor)+100, green(partColor)+100, blue(partColor)+100, 255));
    circle(0, 0, radius*2f); //Rectangle alternative -- Best Performance

    fill(partColor);
    circle(0, 0, radius*1.7f);

    popMatrix(); //END: Matrix with the position and rotation of the particle
  }
}
