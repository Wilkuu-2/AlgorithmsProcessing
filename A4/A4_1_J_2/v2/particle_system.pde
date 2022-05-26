// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector spawnPoint;

  ParticleSystem(PVector position) {
    spawnPoint = position;
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
   
    particles.add(new Particle(spawnPoint));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
