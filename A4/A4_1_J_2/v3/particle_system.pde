

class ParticleSystem {

  ArrayList<Particle> particles;// array for the particle
  PVector origin;  // location of the where the system will be

  ParticleSystem(PVector v) { //num is the size of the particles spawnd
    particles = new ArrayList<Particle>();// Initialize the arraylist
    origin = v.copy();// origin will copy the location of the object
    particles.add(new Particle(origin));// creates the particle
  }


  void run() {
    // Cycle through the ArrayList backwards, because deleting while iterating
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.spanTime()) {
        particles.remove(i);
      }
    }
  }

  void addParticle() {
    Particle p;
    p = new Particle(origin);
    particles.add(p);
  }
    void Pop() {
      for (int i=0; i<10; i++) {
        addParticle();
      }
    }
  

  void addParticle(Particle p) {
    particles.add(p);
  }

  // A method to test if the particle system still has particles
  boolean dead() {
    return particles.isEmpty();
  }
  void addLocation(PVector pos) { // recives the location from class object and tells the system to spawn the particles in the center of the object
    origin.set(pos.copy());
  }
}
