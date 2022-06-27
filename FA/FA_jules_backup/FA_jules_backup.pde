Enviroment env;
Bubblesystem bs;
Sub sub;

ArrayList<Fish> fishs=new ArrayList<Fish>();

PImage office;

void setup() {

  //fullScreen();
  size(1000, 700);
  env = new Enviroment();
  bs = new Bubblesystem(new PVector(width/5, height-height/4));
  sub = new Sub();
// got the image from : https://www.freepik.com/free-vector/cartoon-illustration-empty-office-with-window-modern-interior-with-furniture_3519647.htm#query=office%20window&position=11&from_view=keyword
  office=loadImage("office.1.png");

  for (int i=0; i<300; i++) {
    Fish fish=new Fish(new PVector( random(width/15, width), 0));
    fishs.add(fish);
  }
}

void draw() {

  image(office, 0, 0);
  office.resize(width, height);

  env.display();
  bs.addParticle();
  bs.run();
  for (Fish fish : fishs) {

    fish.run(fishs, sub);
  }
  sub.run();
  env.glass();
}

void mouseClicked() {
  for (Fish fish : fishs) {
    //println("here");
    fish.position();
  }
}
