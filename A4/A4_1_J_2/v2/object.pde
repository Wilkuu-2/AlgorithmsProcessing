class Object {
  PVector objLocation, objSpeed;
  float size=20;
  ParticleSystem ps;
  Object(float objx, float objy ) {
    objLocation =new PVector(0, 0);
    objSpeed =new PVector(2.9, 2.7);
    ps = new ParticleSystem(new PVector(objLocation.x, objLocation.y));
    
    objLocation.x=objx;
    objLocation.y=objy;
  }

  void display() {
    fill(random(0,255),random(0,255), random(0,255));
    ellipse(objLocation.x, objLocation.y, size, size);
   ps.addParticle();
   ps.run();
    
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
}
