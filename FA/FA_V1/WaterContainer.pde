/*
  WaterContainer
  
  This class containes the water surface
  
   Copyright 2022 Jakub Stachurski and Jules Verhagen
*/

class WaterContainer {
  WaterSegment[] segments;
  PVector pos;
  PVector size;
  float segmentInterval;
  
  
  // -- Constructor 
  WaterContainer(PVector pos, PVector size) {
    segments = new WaterSegment[100];

    for (int i = 0; i < segments.length; i++)
      segments[i] = new WaterSegment(noise(i/float(segments.length)*size.x)*20f);

    this.pos  = pos;
    this.size = size;

    segmentInterval = size.x / (segments.length -1);
  }
  
  // Resize 
  void setSize(PVector newPos, PVector newSize) {
    pos = newPos;
    size = newSize;
    segmentInterval = size.x / (segments.length -1);
  }

  // Set up for drawing the water surface 
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    strokeWeight(5);
    for (int i = 1; i < segments.length; i++) {
      segments[i].display(segmentInterval, i, segments[i-1]);
    }
    // Draw the bottom side of the water 
    fill(0x7F3735A5);
    noStroke();
    rect(0, WaterSegment.bottomOffset -0.45f, size.x, size.y - WaterSegment.bottomOffset);


    popMatrix();
  }
   
  // -- Update state of the water segements 
  void update() {
    segments[0].update(null, segments[1]);

    for (int i = 1; i < segments.length - 1; i++) {
      segments[i].update(segments[i-1], segments[i+1]);
    }
    segments[segments.length-1].update(segments[segments.length-1], null);
  }
  
  // Particle collision
  void collide(ArrayList<? extends Particle> collidables) {
    for (int i = 0; i < segments.length - 1; i++)
      for (Particle col : collidables)
        segments[i].collide(new PVector(pos.x + segmentInterval * i, pos.y), col);
  }
  // Fish collision 
    void collideFishes(ArrayList<Fish> fishes) {
    for (int i = 0; i < segments.length - 1; i++)
      for (Fish f : fishes)
        segments[i].collide(new PVector(pos.x + segmentInterval * i, pos.y), f);
  }
}
