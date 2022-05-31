class Object {
  //ArrayList<ParticleSystem> systems;
  PVector objLocation, objSpeed;
  float size=20;
  boolean trigget =false;
  ParticleSystem ps;// call partical system
  Object(float objx, float objy ) {
    objLocation =new PVector(0, 0);
    objSpeed =new PVector(2.9, 2.7);


    ps= new  ParticleSystem ( new PVector(objLocation.x, objLocation.y));
    //systems = new ArrayList<ParticleSystem>();
    objLocation.x=objx;
    objLocation.y=objy;
  }

  void display() {
    fill(255);
    ellipse(objLocation.x, objLocation.y, size, size);
  }

  void movement() {
    objLocation.add(objSpeed);
    // collision with the edges
    if (objLocation.x>width-size||objLocation.x<size) {
      objSpeed.x*=-1;
    }
    if (objLocation.y>height-size||objLocation.y<size) {
      objSpeed.y*=-1;
    }
  }

  void update() {

    ps.run();
    ps.addParticle();
    ps.addLocation(objLocation);// gives particle system the location of the object in this class
  }
  
  
  void trigger() {
    for(int i =0; i<10;i++){
    ps.Pop();}
    
   
  }
}
