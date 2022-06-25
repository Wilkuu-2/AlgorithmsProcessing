// a class that will add Bubbles like Bubble
class Bubblesystem {
  ArrayList<Bubble> Bubbles;
  PVector origin;
  float num, counter;

  Bubblesystem(PVector position) {
    origin = position.copy();
    Bubbles = new ArrayList<Bubble>();
  }

  void addParticle() {
    num=int(random(1, 11));
    if (num==1) {
      Bubbles.add(new Bubble(origin, 1));
      counter++;
    }
    if (counter==5) {
      int chance=int(random(1, 5));
      if (chance==1) {
        Bubbles.add(new Bubble(origin, 3));
      }
      counter=0;
    }
  }

  void run() {
    for (int i = Bubbles.size()-1; i >= 0; i--) {
      Bubble p = Bubbles.get(i);
      p.run();
      if (p.surface()) {
        Bubbles.remove(i);
      }
    }
  }
  
  void move(PVector newpos){
    origin = newpos.copy();
  }
}
