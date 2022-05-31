/**
 * Multiple Particle Systems
 * by Daniel Shiffman.
 *
 * Click the mouse to generate a burst of particles
 * at mouse position.
 *
 * Each burst is one instance of a particle system
 * with Particles and CrazyParticles (a subclass of Particle). 
 * Note use of Inheritance and Polymorphism.
 */
Object obj;
//ArrayList<ParticleSystem> systems;

void setup() {
  size(640, 360);
  //systems = new ArrayList<ParticleSystem>();
  obj = new Object(width/2, height/2);
}

void draw() {
  background(50);
  obj.update();
  obj.movement();
  obj.display();
}

void mousePressed() {
obj.trigger();

}
