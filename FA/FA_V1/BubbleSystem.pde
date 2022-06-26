// Continer for instances of Bubble

class BubbleSystem {

  long updateNanos = System.nanoTime();
  long drawNanos   = System.nanoTime();

  ArrayList<Bubble> bubbles;
  PVector origin;
  int counter;

  BubbleSystem(PVector position) {
    origin = position.copy();
    bubbles = new ArrayList<Bubble>();
  }

  void addParticle() {
    switch(counter) {
    case 5:
      if (round(random(0, 5)) == 1) {
        bubbles.add(new Bubble(origin, 3));
      }
      counter=0;
      break;
    default:
      if (round(random(0, 10)) == 1) {
        bubbles.add(new Bubble(origin, 1));
        counter++;
      }
    }
  }

  void update() {

    updateNanos = System.nanoTime();

    for (Bubble b : bubbles)
      b.update();
    bubbles.removeIf(b -> b.surface());

    updateNanos = System.nanoTime() - updateNanos; //Stop counting time
  }

  void display() {
    drawNanos = System.nanoTime();

    for (Bubble b : bubbles)
      b.display();

    drawNanos = System.nanoTime() - drawNanos; //Stop counting time
  }

  void move(PVector newpos) {
    origin = newpos.copy();
  }
}
