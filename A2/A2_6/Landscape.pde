

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
    
    // Update mountain at the end
    update();
  }

  // Add to offset to move along the noise function
  void move(float steps) {
    offX  += steps;
    update();
  }
  // Change the scaling of the noise function 
  void scale(float scale){
    rez *= scale; 
    // Update at the end 
    update();
  }

  void update() {
    // Wipe previous 
    mountainIm.beginDraw();
    mountainIm.background(color(255, 255, 100, 0));
    mountainIm.endDraw();
    

    println("UPDATING");
    
    for (int w = 0; w < size.x; w++) { //Iterate over width
      for (int h = floor(size.y-(noise((w+offX)/rez) * size.y)); h < size.y; h++) //Iterate down over height, starting from the noise fuction result
        mountainIm.pixels[floor(w + (size.x * h ))] = col;
    }
    // Save pixels
    mountainIm.updatePixels();
    println("UPDATED");
  }

  void display() {
    // Put image in position
    image(mountainIm, position.x, position.y);
  }
}
