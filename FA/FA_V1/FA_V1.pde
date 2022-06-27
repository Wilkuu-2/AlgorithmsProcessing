/*
  Final Assignment [M4] Algorithms
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 
 */

Enviroment env;
BubbleSystem bs;
PelletSystem ps;
Foliage foliage;
PImage office;
PVector screenSize;
long nanosElapsed = System.nanoTime();
long nanos        = System.nanoTime();
WaterContainer water;

void setup() {
  //fullScreen();
  size(1000, 1000, P2D);
  screenSize = new PVector(width, height);

  env = new Enviroment();
  office=loadImage("office.1.png");
  //bs = new BubbleSystem(new PVector(width/3.5f, height-height/4.5));
  bs = new BubbleSystem(env.getVaseBubblePoint().add(new PVector(height/16f, -height/16f)),
                        new PVector(width/16f, height/16f),
                        new PVector(width-width/8f, height/1.32f));

  ps = new PelletSystem(new PVector(width/16.05f, height/16f),
                        new PVector(width-width/8.1f, height/1.36f));

    
  foliage = new Foliage();
  surface.setResizable(true);
  water = new WaterContainer(new PVector(width/16f, height/6f), new PVector(width-width/8f, height/1.32f));
}

void draw() {
  nanos = System.nanoTime(); // Start counting time

  bs.spawn(random(0.06, 0.25));

  // Update
  bs.update();
  ps.update();
  foliage.update();
  water.update();
  water.collide(bs.particles);
  water.collide(ps.particles);

  // Resize
  if (screenSize.x != width || screenSize.y != height) {
    screenSize.x = width;
    screenSize.y = height;

    //bs.move(env.getVaseBubblePoint().add(new PVector(height/16, -height/16)));
    bs.reSize(env.getVaseBubblePoint().add(new PVector(height/16, -height/16)),
      new PVector(width/16f, height/16f),
      new PVector(width-width/8f, height/1.32f));

    ps.reSize(env.getVaseBubblePoint().add(new PVector(height/16, -height/16)),
      new PVector(width/16f, height/16f),
      new PVector(width-width/8f, height/1.32f));

    office.resize(round(screenSize.x), round(screenSize.y));
    env.redrawSand();
    foliage.reposition();
    water.setSize(new PVector(width/16f, height/6f), new PVector(width-width/8f, height/1.32f));
  }
  //background(255);
  image(office, 0, 0);

  //  Display all elements
  env.display();
  bs.display();
  ps.display();
  foliage.display();
  water.display();
  env.displayFront();


  // Benchmarking
  fill(0);
  text(String.format("FPS: %.5f", frameRate), 10, 20);
  text(String.format("TPF: %.5f ms", nanosElapsed/1000000f ), 10, 30);

  text(String.format("FOLIAGE:"), 10, 40);
  text(String.format("[Update]: %.5f ms", foliage.updateNanos/1000000f), 20, 50);
  text(String.format("[Draw]: %.5f ms", foliage.drawNanos/1000000f ), 20, 60);

  text(String.format("BUBBLES: %d", bs.particles.size()), 10, 70);
  text(String.format("[Update]: %.5f ms", bs.updateNanos/1000000f), 20, 80);
  text(String.format("[Draw]: %.5f ms", bs.drawNanos/1000000f ), 20, 90);

  text(String.format("ENVIROMENT:"), 200, 40);
  text(String.format("[DrawFront]: %.5f ms", env.frontNanos/1000000f), 210, 50);
  text(String.format("[DrawBack]: %.5f ms", env.backNanos/1000000f ), 210, 60);

  nanosElapsed = System.nanoTime() - nanos; //Stop counting time
}


void mouseDragged() {
  if(mouseY < height/7f && mouseX > width/12f && mouseX  < width - width/12f)
    ps.spawn(new PVector(mouseX, mouseY), 0.4f);
}
