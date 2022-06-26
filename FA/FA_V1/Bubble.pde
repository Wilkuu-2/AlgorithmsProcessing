// A simple Bubble class

class Bubble {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float colorBubble=0, size=0, sizeVar;

  Bubble(PVector l, float initSize) {
    acceleration = new PVector(0, -0.025);
    velocity = new PVector(random(-0.5, 0.5), random(-2, 0));
    position = l.copy();
    sizeVar=initSize;
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    colorBubble = position.y;
    size=(height/30-position.y/30)*sizeVar;
  }

  // Method to display
  void display() {
    noStroke();
    
    fill(82, 101, 255, colorBubble);
    circle(position.x+1, position.y, size/2.5);
   
   
   fill(255, colorBubble);
    circle(position.x+1, position.y, size/3);
    

  }

  // Is the Bubble still useful?
  boolean surface() {
    if (position.y < width/15) {
      return true;
    } else {
      return false;
    }
  }
}
