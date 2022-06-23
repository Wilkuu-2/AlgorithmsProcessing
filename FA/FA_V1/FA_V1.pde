Enviroment env;

PImage office;
void setup() {
 //fullScreen();
 size(1000,1000, P2D);
  env = new Enviroment();
  office=loadImage("office.1.png");
 surface.setResizable(true);
}

void draw() {
  
  image(office,0,0);
  office.resize(width, height);

  env.display();
}
