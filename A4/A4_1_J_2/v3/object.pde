class Object {
  ArrayList<ParticleSystem> systems;
  PVector objLocation, objSpeed;
  float size=20;
  ParticleSystem ps;
  Object(float objx, float objy ) {
    objLocation =new PVector(0, 0);
    objSpeed =new PVector(2.9, 2.7);
    
    systems = new ArrayList<ParticleSystem>();
    objLocation.x=objx;
    objLocation.y=objy;
  }

  void display() {
    fill(255);
    ellipse(objLocation.x, objLocation.y, size, size);
  
    
  }

  void movement() {
    objLocation.add(objSpeed);

    if (objLocation.x>width-size||objLocation.x<size) {
      objSpeed.x*=-1;
    }
    if (objLocation.y>height-size||objLocation.y<size) {
      objSpeed.y*=-1;
    }
  }
  
  void update(){
   for (ParticleSystem ps : systems) {
    ps.run();
    ps.addParticle();
  }
  systems.add(new ParticleSystem(1, new PVector(objLocation.x, objLocation.y)));
  }
}
