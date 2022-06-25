Enviroment env;
Bubblesystem bs;
Flock flock;

PImage office;
void setup() {
  //fullScreen();
  size(1000, 700);
  env = new Enviroment();
  bs = new Bubblesystem(new PVector(width/5, height-height/4));
  office=loadImage("office.1.png");
  flock = new Flock();
  for (int i = 0; i < 150; i++) {
    flock.addBoid(new Boid(random(width/15,width-width/15), random(height/15,height-height/15)));
  }
}

void draw() {

  image(office, 0, 0);
  office.resize(width, height);

  env.display();
  bs.addParticle();
  bs.run();
  flock.run();
  env.glass();
}

void mouseClicked(){


}
