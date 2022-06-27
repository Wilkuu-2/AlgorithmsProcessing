


class PelletSystem extends ParticleSystem<Pellet>{
  float SPAWN_DISTANCE = 10;
  float SPAWN_SPEED_MIN = 1;
  float SPAWN_SPEED_MAX = 2;
  float SPAWN_ACCELERATION_MIN = 0.00001;
  float SPAWN_ACCELERATION_MAX = 0.00015;
  float SPAWN_RADIUS_MIN = 8;
  float SPAWN_RADIUS_MAX = 12;
  float SPAWN_ROTVELVAR  = PI; 
  float fractionalParticleCount = 0f;
  PVector GRAVITY = new PVector(0, 0.1f);
  
  // -- Constructor
   PelletSystem(PVector boundPos, PVector boundSize) {
    super(new PVector(0,0),boundPos,boundSize);
  }
  
  // -- Enable collision between fish and particle
  void collide(ArrayList<Fish> fishes){
    for(Pellet p : particles) for(Fish f : fishes)
        p.collide(f);
      
    
  }
  // -- Spawn method
  void spawn(PVector mPos, float n) {
    fractionalParticleCount += n;

    for (int i = 0; i < floor(fractionalParticleCount); i++) {
      PVector pos = PVector.random2D().mult(random(0, SPAWN_DISTANCE));
      PVector vel = PVector.random2D().mult(random(SPAWN_SPEED_MIN, SPAWN_SPEED_MAX));
      PVector acc = PVector.add(pos.copy().mult(random(SPAWN_ACCELERATION_MIN, SPAWN_ACCELERATION_MAX)), GRAVITY);
      pos.add(mPos);
      
      // Creating the particle
      particles.add(new Pellet(pos,
        vel,
        acc,
        random(SPAWN_RADIUS_MIN, SPAWN_RADIUS_MAX),
        random(-TWO_PI, TWO_PI),
        random(-SPAWN_ROTVELVAR,SPAWN_ROTVELVAR),
        color(random(100, 120), random(120, 150), random(220, 250))
        ));
      fractionalParticleCount --;
    }
  }
}

class Pellet extends Particle{
  float FISH_DAMAGE_RADIUS_FALLOFF;
  
  // -- Constructor 
  Pellet(PVector pos, PVector vel, PVector acc, float rad, float rot, float rVel, color col) {
    super(pos, vel, acc, rad, rot,rVel ,col);
    FRICTION_COEFF = 0.01f;
    PART_DENSITY = 0.8f;
    RADIUS_FALLOFF =0.9991f;
    OPACITY_FALLOFF = 0.99954f;
    FISH_DAMAGE_RADIUS_FALLOFF = 0.991f;
  } 
 
 // Gets smaller when a fish is in range 
 void collide(Fish f){
   PVector toFish = PVector.sub(f.position,vPos);
   if(toFish.mag() < radius + f.r + 10){
     radius *= FISH_DAMAGE_RADIUS_FALLOFF; 
   }
 }
 
 // -- Display 
 void display(){
    pushMatrix();
    translate(vPos.x,vPos.y);
    rotate(rot);
    fill(0);
    rect(-radius,-radius, radius*2f, radius*2f);
    popMatrix();
    
  }


}
