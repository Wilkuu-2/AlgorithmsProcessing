

class ParticleSystem<T extends Particle> {
  float SPAWN_DISTANCE = 10;
  float SPAWN_SPEED_MIN = 1;
  float SPAWN_SPEED_MAX = 2;
  float SPAWN_ACCELERATION_MIN = 0.00001;
  float SPAWN_ACCELERATION_MAX = 0.00015;
  float SPAWN_RADIUS_MIN = 3;
  float SPAWN_RADIUS_MAX = 8;
  float fractionalParticleCount = 0f;
  PVector GRAVITY = new PVector(0, -0.05f);

  long updateNanos = System.nanoTime();
  long drawNanos   = System.nanoTime();

  PVector vPos;
  ArrayList<T> particles;
  ParticleSystem(PVector vPos){
    this.vPos = vPos.copy();
    particles = new ArrayList<T>();
    
  }
  
  void setPos(PVector newPos) {
    vPos = newPos.copy();
  }

  // -- State updated
  void update() {
    updateNanos = System.nanoTime();
    // Pass update to particles
    for (T p : particles)
      p.update();

    particles.removeIf( p -> p.deleteMe); //Autodelete dead particles using a predicate/lambda
    updateNanos = System.nanoTime() - updateNanos; //Stop counting time
  }

  void display() {
    drawNanos = System.nanoTime();
    // Pass draw call to particles
    for (T p : particles)
      p.display();
    drawNanos = System.nanoTime() - drawNanos; //Stop counting time

  }
  
  int getParticleCount() {
    return particles.size();
  }
  void logParticleCount() {
    println("[PARTICLE] Particles: ", particles.size());
  }
}
