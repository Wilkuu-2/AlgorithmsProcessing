Enviroment env;
Bubblesystem bs;
PImage office;
void setup() {
  //fullScreen();
  size(1000, 700);
  env = new Enviroment();
 bs = new Bubblesystem(new PVector(width/5, height-height/4));
  office=loadImage("office.1.png");
}

void draw() {

  image(office, 0, 0);
  office.resize(width, height);

  env.display();
  bs.addParticle();
  bs.run();
}
