class Segments {
  Segments() {
    acc = new PVector(0, 0);
  }


  PVector acc;
  float noiseScale = 0.02;
  float noiseVal;
  void display() {
    pushMatrix();
    translate(width/2, 0);
    line(noiseVal*80, 0, 0, height);
    popMatrix();
  }

  void run() {
    movement();
    display();
  }
  void movement() {

    noiseVal= noise(1*noiseScale, 1*noiseScale);
    noiseScale+=0.01;
  }
}
