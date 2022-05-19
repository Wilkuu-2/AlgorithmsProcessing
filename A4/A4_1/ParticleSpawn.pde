/*
  ParticleSource 
    Container class for the particles
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/



final static PVector GRAVITY = new PVector(0,-0.5);

class ParticleSpawner{
  PVector vPos;
  ArrayList<Particle> particles;
  
  ParticleSpawner(PVector pos){
    vPos = pos.copy(); 
    particles = new ArrayList<Particle>(100); //Allocate 100 particles
  }
  
  void setPos(PVector newPos){
    vPos = newPos.copy();
  }

  void update(){
    for(Particle p : particles)
      p.update();
    
    particles.removeIf( p -> p.deleteMe); //Autodelete dead particles 
  
  }
  
  void display(){
    for(Particle p : particles)
      p.display(); 
  }
  
  void spawn(int n){
    for(int i = 0; i < n; i++){
      PVector pos = PVector.random2D().mult(random(0,SPAWN_DISTANCE));
      PVector vel = PVector.random2D().mult(random(SPAWN_SPEED_MIN, SPAWN_SPEED_MAX));
      PVector acc = PVector.add(pos.copy().mult(random(SPAWN_ACCELERATION_MIN, SPAWN_ACCELERATION_MAX)), GRAVITY);
      pos.add(vPos);
      colorMode(HSB, 360, 100, 100);
      
      particles.add(new Particle(pos,
                                 vel,
                                 acc,
                                 random(-TWO_PI,TWO_PI),
                                 random(-TWO_PI,TWO_PI)* SPAWN_ROT_VEL_FACTOR,
                                 random(SPAWN_RADIUS_MIN,SPAWN_RADIUS_MAX),
                                 color(noise(millis()/300f) * 3600f % 60 ,random(95,100),random(95,100))
                                 ));
    }
  }
   void logParticleCount(){
     println("[PARTICLE] Particles: ", particles.size());
   }
  
}
