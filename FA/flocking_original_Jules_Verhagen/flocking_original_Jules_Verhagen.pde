
Sub sub;

ArrayList<Fish> fishs=new ArrayList<Fish>();



void setup() {

  //fullScreen();
  size(1000, 700);

  sub = new Sub();

 

  for (int i=0; i<1000; i++) {
    Fish fish=new Fish(new PVector( random(width/15, width), random(height)));
    fishs.add(fish);
  }
}

void draw() {

background(255);


  for (Fish fish : fishs) {

    fish.run(fishs, sub);
  }
  sub.run();
 
}

void mouseClicked() {
  for (Fish fish : fishs) {
    //println("here");
    fish.position();
  }
}
