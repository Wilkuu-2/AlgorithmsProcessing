Enviroment env;

PImage office;
void setup() {
 //fullScreen();
 size(1000,1000);
  env = new Enviroment();
  office=loadImage("office.1.png");
}

void draw() {
  
  image(office,0,0);
  office.resize(width, height);

  env.display();
}
