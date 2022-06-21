/*
  Wall
 
 The wall class will react to all balls hitting it by requesting
 */

class Wall {
  private final PGraphics wallImage;
  private final PVector VPos;
  private final PVector VSize;
  private final color imprintColor, wallColor;
  private long msCounter;

  // -- Constructor
  Wall(PVector pos, PVector size, color wallColor, color imprintColor) {
    this.VPos = pos;
    this.VSize = size;
    wallImage = createGraphics(round(size.x), round(size.y));
    this.imprintColor = imprintColor;
    this.wallColor = wallColor;
    msCounter = millis();
    reset();
  }

  void display() {
    image(wallImage, VPos.x, VPos.y);
  }
  
  void update(){
    
    if (FADE_OLD_IMPRINTS && msCounter < millis()) {
      wallImage.beginDraw();
      wallImage.noStroke();
      wallImage.fill(wallColor & 0x06FFFFFF);
      wallImage.rect(0, 0, VSize.x, VSize.y);
      wallImage.endDraw();
      msCounter = millis() + FADE_DELAY; 
    }
  
  }

  void reset() {
    wallImage.beginDraw();
    wallImage.background(wallColor);
    wallImage.endDraw();
  }

  void imprint(PVector lastPos, PVector pos, float radius) {
    PVector nPos = PVector.sub(pos, VPos);
    wallImage.beginDraw();


    if (lastPos != null) {
      PVector nLPos = PVector.sub(lastPos, VPos);
      wallImage.strokeWeight(radius*2);
      wallImage.stroke(imprintColor);
      wallImage.line(nLPos.x, nLPos.y, nPos.x, nPos.y);
    } else {
      wallImage.fill(imprintColor);
      wallImage.noStroke();
      wallImage.circle(nPos.x, nPos.y, radius*2);
    }
    

    wallImage.endDraw();
  }
}
