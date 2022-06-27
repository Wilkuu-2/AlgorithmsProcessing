
class Bubble {

  PVector speed, location;
  PVector acceleration;
  float colorBubble=0, size=0, sizeVar;

  Bubble(PVector initLocation, float initSize) {
    acceleration = new PVector(0, -0.025);
    speed = new PVector(random(-0.5, 0.5), random(-2, 0));
    location = initLocation.copy();
    sizeVar=initSize;
  }

  void run() {
    update();
    display();
  }

  // location of bubble is updated 
  void update() {
    speed.add(acceleration);
    location.add(speed);
    colorBubble = location.y;
    size=(height/30-location.y/30)*sizeVar;
  }

  // bubble form 
  void display() {
    noStroke();
    fill(125, 191, 255, colorBubble);
    ellipse(location.x, location.y, size, size);
    fill(255, colorBubble);
    ellipse(location.x+1, location.y, size/2, size/3);
  }

//if the bubble reatches the surface it will delete its self so there wont be any lag 
 
  boolean surface() {
    if (location.y < width/20) {
      return true;
    } else {
      return false;
    }
  }
}
