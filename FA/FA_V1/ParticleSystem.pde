/*
 Particle
 A superclass for container templates for particles
 This template includes:
 Keeping track of execution time
 Conditional deletion
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

class ParticleSystem<T extends Particle> {
  // Bounding box 
  PVector boundPos;
  PVector boundSize;
  // Spawner pos 
  PVector vPos;
  // Particles
  ArrayList<T> particles;

  // -- Construtor 
  ParticleSystem(PVector vPos, PVector boundPos, PVector boundSize) {
    this.vPos = vPos.copy();
    particles = new ArrayList<T>();
    this.boundPos = boundPos.copy();
    this.boundSize = boundSize.copy();
  }
  // -- Resize
  void reSize(PVector newPos, PVector boundPos, PVector boundSize) {
    vPos = newPos.copy();
    this.boundPos = boundPos.copy();
    this.boundSize = boundSize.copy();
  }

  // -- State updated
  void update() {

    // Pass update to particles
    for (T p : particles)
      p.update(boundPos, boundSize);

    particles.removeIf( p -> p.deleteMe); //Autodelete dead particles using a predicate/lambda
  }

  void display() {

    // Pass draw call to particles
    for (T p : particles)
      p.display();
  }

  int getParticleCount() {
    return particles.size();
  }
  void logParticleCount() {
    println("[PARTICLE] Particles: ", particles.size());
  }
}
