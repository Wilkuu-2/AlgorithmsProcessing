/*
 Particle
 A superclass for container templates for particles
 This template includes:
   Keeping track of execution time
   Conditional deletion 
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

class ParticleSystem<T extends Particle> {
  long updateNanos = System.nanoTime();
  long drawNanos   = System.nanoTime();

  PVector boundPos;
  PVector boundSize; 
  PVector vPos;
  ArrayList<T> particles;
  
  ParticleSystem(PVector vPos,PVector boundPos, PVector boundSize){
    this.vPos = vPos.copy();
    particles = new ArrayList<T>();
    this.boundPos = boundPos.copy();
    this.boundSize = boundSize.copy();
    
  }
  
  void reSize(PVector newPos, PVector boundPos, PVector boundSize) {
    vPos = newPos.copy();
    this.boundPos = boundPos.copy();
    this.boundSize = boundSize.copy();
  }

  // -- State updated
  void update() {
    updateNanos = System.nanoTime();
    // Pass update to particles
    for (T p : particles)
      p.update(boundPos,boundSize);

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
