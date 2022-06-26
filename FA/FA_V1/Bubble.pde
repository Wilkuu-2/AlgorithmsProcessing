class Bubble extends Particle {
  boolean deleteMe = false;

  // -- Constructor
  Bubble(PVector pos, PVector vel, PVector acc, float rad, color col) {
    super(pos, vel, acc, rad, col);
    FRICTION_COEFF = 0.1f;
    PART_DENSITY = 0.1f;
    RADIUS_FALLOFF = 1.003f;
    OPACITY_FALLOFF = 0.997f;
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
