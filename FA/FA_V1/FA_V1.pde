Enviroment env;
BubbleSystem bs;
Foliage foliage;
PImage office;
PVector screenSize;
long nanosElapsed = System.nanoTime();
long nanos        = System.nanoTime();

void setup() {
  screenSize = new PVector(width, height);
  //fullScreen();
  size(1000, 1000, P2D);
  
  env = new Enviroment();
  office=loadImage("office.1.png");
  //bs = new BubbleSystem(new PVector(width/3.5f, height-height/4.5));
  bs = new BubbleSystem(new PVector(width/3.5f, height-height/4.5));
  surface.setResizable(true);
  foliage = new Foliage();
}

void draw() {
  nanos = System.nanoTime(); // Start counting time
  
  bs.spawn(random(0.06,0.25));

  // Update
  bs.update();   
  foliage.update();
  
  // Resize
  if (screenSize.x != width || screenSize.y != height) {
    screenSize.x = width;
    screenSize.y = height;

    //bs.move(env.getVaseBubblePoint().add(new PVector(height/16, -height/16)));
    bs.setPos(env.getVaseBubblePoint().add(new PVector(height/16, -height/16)));
    office.resize(round(screenSize.x), round(screenSize.y));
    env.redrawSand();
    foliage.reposition();
  }
  //background(255);
  image(office, 0, 0);

  //  Display all elements 
  env.display();
  bs.display();
  foliage.display();
  env.displayFront();


  // Benchmarking 
  fill(0);
  text(String.format("FPS: %.5f", frameRate      ), 10, 20);
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
