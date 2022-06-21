Fish fish;

void setup(){
size (500,500);

fish = new Fish();
}

void draw(){
  background(0);
fish.display();
}


void mouseDragged(){
  
fish.increse();
}
