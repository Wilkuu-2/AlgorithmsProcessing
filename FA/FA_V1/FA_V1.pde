Enviroment env;


void setup(){
fullScreen();
env = new Enviroment();
}

void draw(){
  background(0);
  env.display();

}
