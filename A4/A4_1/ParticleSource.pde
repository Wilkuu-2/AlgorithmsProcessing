/*
  ParticleSource 
    Container class for the particles
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

final static float SPAWN_DISTANCE = 100;
final static float SPAWN_SPEED_MIN = 5;
final static float SPAWN_SPEED_MAX = 10;
final static float SPAWN_ACCELERATION_MIN = 0.01;
final static float SPAWN_ACCELERATION_MAX = 0.015;
final static float SPAWN_ROT_VEL_FACTOR = 0.1;
final static float SPAWN_RADIUS_MIN = 10;
final static float SPAWN_RADIUS_MAX = 30;

final static PVector GRAVITY = new PVector(0,0.5);

class ParticleSource{
  PVector vPos;
  
  ArrayList<Particle> particles;
  
  ParticleSource(PVector pos){
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
      PVector pos = PVector.random2D().mult(SPAWN_DISTANCE);
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
                                 color(noise(millis()/300f) * 3600f % 360 ,random(95,100),random(95,100))
                                 ));
    }
  }
   void logParticleCount(){
     println("[PARTICLE] Particles: ", particles.size());
   }
  
}
