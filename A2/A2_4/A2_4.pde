
int num=560;
float[] disctanceX = new float[num];
float[] disctanceY = new float[num];
float[] size = new float[num];
void setup() {
  size(800, 800);
  for (int i = 0; i < disctanceX.length; i++) {
    disctanceX[i] = int(randomGaussian() * 80);
  }
  for (int i = 0; i < disctanceY.length; i++) {
    disctanceY[i] = int(randomGaussian() * 80);
  }
  for (int i = 0; i < size.length; i++) {
    size[i] = int(randomGaussian() * 10);
  }
}

void draw() {
  noStroke();
  background(204);
  
  translate(width/2, width/2);

  for (int i = 0; i < disctanceX.length; i++) {
    fill(0,0,255);
    rotate(TWO_PI/disctanceX.length);
    
    float distX = abs(disctanceX[i]);
    float distY = abs(disctanceY[i]);
    float sizeP = abs(size[i]);
    circle(distX, distY, sizeP);
  }
}
