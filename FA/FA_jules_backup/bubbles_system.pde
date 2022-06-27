// a class that will add Bubbles like Bubble
class Bubblesystem {
  ArrayList<Bubble> Bubbles;
  PVector center;
  float num, counter;

  Bubblesystem(PVector location) {
    center = location.copy();
    Bubbles = new ArrayList<Bubble>();
  }
  void run() {
    for (int i = Bubbles.size()-1; i >= 0; i--) { //starts from the size then gose down so there wont be any errors 
      Bubble bub = Bubbles.get(i);
      bub.run();
      if (bub.surface()) {
        Bubbles.remove(i);
      }
    }
  }
  void addParticle() {
  
    //added a factor of randomenss so that the programm wont spawn particles contantly
      num=int(random(1, 11)); 
    println(num);
    if (num==1) { // every time num== 1 spawns particle 
      Bubbles.add(new Bubble(center, 1));
      counter++;// counter will go up every time a particle spawns 
    }
    if (counter==5) {
      // if the counter is 5 there is a 50% 50% chance to spawn a particle with 3 times the size 
      int chance=int(random(1, 5));
      if (chance==1) {
        Bubbles.add(new Bubble(center, 3));
      }
      counter=0;
    }
  }


}
