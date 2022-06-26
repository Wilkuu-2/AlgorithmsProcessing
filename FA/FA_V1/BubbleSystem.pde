/*
  ParticleSource
 Container class for the particles
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */





class BubbleSystem {
  final static float SPAWN_DISTANCE = 10;
  final static float SPAWN_SPEED_MIN = 1;
  final static float SPAWN_SPEED_MAX = 2;
  final static float SPAWN_ACCELERATION_MIN = 0.00001;
  final static float SPAWN_ACCELERATION_MAX = 0.00015;
  final static float SPAWN_RADIUS_MIN = 3;
  final static float SPAWN_RADIUS_MAX = 8;
  
  float fractionalParticleCount = 0f; 

  final PVector GRAVITY = new PVector(0, -0.05f);

  long updateNanos = System.nanoTime();
  long drawNanos   = System.nanoTime();

  PVector vPos;
  ArrayList<Bubble> particles;

  BubbleSystem(PVector pos) {
    vPos = pos.copy();
    particles = new ArrayList<Bubble>(2000); //Allocate 2000 particles in the beginning
  }

  void setPos(PVector newPos) {
    vPos = newPos.copy();
  }

  // -- State updated
  void update() {
    updateNanos = System.nanoTime();
    // Pass update to particles
    for (Bubble p : particles)
      p.update();

    particles.removeIf( p -> p.deleteMe); //Autodelete dead particles using a predicate/lambda
    updateNanos = System.nanoTime() - updateNanos; //Stop counting time
  }

  void display() {
    drawNanos = System.nanoTime();
    // Pass draw call to particles
    for (Bubble p : particles)
      p.display();
    drawNanos = System.nanoTime() - drawNanos; //Stop counting time

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
        color(random(100,120),random(120, 150), random(220, 250))
        ));
      
      fractionalParticleCount --;
    }
  }
  int getParticleCount() {
    return particles.size();
  }
  void logParticleCount() {
    println("[PARTICLE] Particles: ", particles.size());
  }
}
