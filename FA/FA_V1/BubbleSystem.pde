/*
 BubbleSystem
 Container for bubbles
 
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

class BubbleSystem extends ParticleSystem<Bubble> {
  float SPAWN_DISTANCE = 10;
  float SPAWN_SPEED_MIN = 1;
  float SPAWN_SPEED_MAX = 2;
  float SPAWN_ACCELERATION_MIN = 0.00001;
  float SPAWN_ACCELERATION_MAX = 0.00015;
  float SPAWN_RADIUS_MIN = 3;
  float SPAWN_RADIUS_MAX = 8;
  float fractionalParticleCount = 0f;
  PVector GRAVITY = new PVector(0, -0.05f);


  BubbleSystem(PVector pos, PVector boundPos, PVector boundSize) {
    super(pos, boundPos,boundSize);
  }

  void spawn(float n) {
    fractionalParticleCount += n;

    for (int i = 0; i < floor(fractionalParticleCount); i++) {
      PVector pos = PVector.random2D().mult(random(0, SPAWN_DISTANCE));
      PVector vel = PVector.random2D().mult(random(SPAWN_SPEED_MIN, SPAWN_SPEED_MAX));
      PVector acc = PVector.add(pos.copy().mult(random(SPAWN_ACCELERATION_MIN, SPAWN_ACCELERATION_MAX)), GRAVITY);
      pos.add(vPos);

      particles.add(new Bubble(pos,
        vel,
        acc,
        random(SPAWN_RADIUS_MIN, SPAWN_RADIUS_MAX),
        color(random(100, 120), random(120, 150), random(220, 250))
        ));
      fractionalParticleCount --;
    }
  }
}

/*
 Bubbles
 
 A bubble particle
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */


class Bubble extends Particle {
  // -- Constructor
  Bubble(PVector pos, PVector vel, PVector acc, float rad, color col) {
    super(pos, vel, acc, rad, 0, 0, col);
    FRICTION_COEFF = 0.1f;
    PART_DENSITY = 0.1f;
    RADIUS_FALLOFF = 1.003f;
    OPACITY_FALLOFF = 0.997f;
  }
  
  void update2() {
    // Additional rule
    deleteMe = deleteMe || vPos.x > width || vPos.x <0 || vPos.y > height || vPos.y < height *0.16; //Delete particle if it's out of bounds
  }
  void display() {
   
    // -- Matrix with the position and rotation of the particle
    if (!deleteMe) {
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
}
