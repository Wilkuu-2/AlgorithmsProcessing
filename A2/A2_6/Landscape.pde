

class Landscape {
  float offX;
  final PVector size;
  final PVector position;
  final color col;
  final PGraphics mountainIm;
  float rez = 100;

  Landscape(PVector position, PVector size, color mountainColor) {
    this.size = size.copy();
    this.position = position.copy();
    col = mountainColor;

    offX = 0;
    mountainIm = createGraphics((int)size.x, (int)size.y);

    update();
  }

  void move(float steps) {
    offX  += steps;
    update();
  }
  void scale(float scale){
    rez *= scale; 
    println(rez);
    update();
  }

  void update() {
    mountainIm.beginDraw();
    mountainIm.background(color(255, 255, 100, 0));
    mountainIm.endDraw();

    println("UPDATING");
    for (int w = 0; w < size.x; w++) {
      for (int h = floor(size.y-(noise((w+offX)/rez) * size.y)); h < size.y; h++) {
        mountainIm.pixels[floor(w + (size.x * h ))] = col;
        //println("W: ", w, "H: ", h);
      }
    }
    mountainIm.updatePixels();
    println("UPDATED");
  }

  void display() {
    image(mountainIm, position.x, position.y);
  }
}
