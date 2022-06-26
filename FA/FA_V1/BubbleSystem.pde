/*
  ParticleSource
 Container superclass class for the particles
 
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

class BubbleSystem extends ParticleSystem<Bubble> {
  BubbleSystem(PVector pos) {
    super(pos);

    SPAWN_DISTANCE = 10;
    SPAWN_SPEED_MIN = 1;
    SPAWN_SPEED_MAX = 2;
    SPAWN_ACCELERATION_MIN = 0.00001;
    SPAWN_ACCELERATION_MAX = 0.00015;
    SPAWN_RADIUS_MIN = 3;
    SPAWN_RADIUS_MAX = 8;
    fractionalParticleCount = 0f;
    GRAVITY = new PVector(0, -0.05f);
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
