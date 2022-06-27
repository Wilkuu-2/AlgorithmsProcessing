ArrayList<Fish> fishs=new ArrayList<Fish>();

void setup() {
  size(700, 700);

  for (int i=0; i<100; i++) {
    Fish fish=new Fish(new PVector(random(0, width), random(0, height)));
    fishs.add(fish);
  }
}

void draw() {
  background(255);
  for (Fish fish : fishs) {
    
    fish.run(fishs);
  }
}


void mouseClicked(){
for (Fish fish : fishs) {
    println("here");
    fish.position();
 
  }

}
