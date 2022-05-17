class Rain {
  float rainX, rainY;
  float size=5;
  PVector position, speed;
  float xoff=0;
  //xoff = xoff + .01;
  //float n = noise(xoff) * width;

  Rain() {
    position = new PVector(0, 0);
    speed = new PVector(0, 0);
    speed.y=random(1, 5);
    speed.x=random(1, 5);
    position.y=random(0, -height);
    position.x=random(0, width);
  }

  void fall() {
    speed.x=noise(xoff)*4;
    xoff+=0.1;
    position.y+=speed.y;
    position.x+=speed.x;

    if (position.y>height) {
      position.y=random(0, -height);
      position.x=random(-width, width);
    }
  }

  void show() {
    fill(0, 155, 255);
    stroke(0, 0, 0);
    circle(position.x, position.y, size);
  }
}
