

class WaterContainer {
  WaterSegment[] segments;
  PVector pos;
  PVector size;

  float segmentInterval;



  WaterContainer(PVector pos, PVector size) {
    segments = new WaterSegment[200];

    for (int i = 0; i < segments.length; i++)
      segments[i] = new WaterSegment(noise(i/float(segments.length)*size.x)*20f);

    this.pos  = pos;
    this.size = size;

    segmentInterval = size.x / segments.length;
  }

  void setSize(PVector newPos, PVector newSize) {
    pos = newPos;
    size = newSize;
    segmentInterval = size.x / segments.length;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    strokeWeight(5);
    for (int i = 1; i < segments.length; i++) {
      segments[i].display(segmentInterval, i, segments[i-1]);
    }

    fill(0x7F3735A5);
    noStroke();
    rect(0, WaterSegment.bottomOffset -0.5, size.x, size.y - WaterSegment.bottomOffset);


    popMatrix();
  }

  void update() {
    segments[0].update(null, segments[1]);

    for (int i = 1; i < segments.length - 1; i++) {
      segments[i].update(segments[i-1], segments[i+1]);
    }
    segments[segments.length-1].update(segments[segments.length-1], null);
  }
  void collide(ArrayList<? extends Collidable> collidables) {
    for (int i = 0; i < segments.length - 1; i++)
      for (Collidable col : collidables)
        segments[i].collide(new PVector(pos.x + segmentInterval * i, pos.y), col);
  }
}
