/*
  Final Assignment [M4] Algorithms
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 
 */

Enviroment env;
BubbleSystem bs;
PelletSystem ps;
Foliage foliage;
Sub sub;
ArrayList<Fish> fishs;
PImage office;
PVector screenSize;
long nanosElapsed = System.nanoTime();
long nanos        = System.nanoTime();
boolean displayTutorialText = true;
WaterContainer water;

void setup() {
  //fullScreen();
  size(1000, 1000, P2D);
  screenSize = new PVector(width, height);

  fishs = new ArrayList<Fish>();
  for (int i=0; i<300; i++) {
    Fish fish=new Fish(new PVector( random(width/15, width), 0));
    fishs.add(fish);
  }

  sub = new Sub();

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
  sub.update();
  for (Fish fish : fishs) {
    fish.update(fishs, ps.particles ,sub);
  }
  ps.collide(fishs);
  water.update();
  water.collide(bs.particles);
  water.collide(ps.particles);
  water.collideFishes(fishs);

  // Resize
  if (screenSize.x != width || screenSize.y != height) {
    resizeEvent();
  }
  //background(255);
  image(office, 0, 0);

  //  Display all elements
  env.display();
  bs.display();
  ps.display();
  foliage.display();
  for (Fish fish : fishs) {
    fish.display();
  }
  sub.displaySub();
  water.display();
  env.displayFront();
  
  fill(0);
  //Tutorial
  if(displayTutorialText){
    textSize(25);
    textAlign(CENTER);
    text( "!!! DRAG YOUR MOUSE HERE TO DROP FOOD !!!", width/2, 80);
  }

  // Benchmarking
  
  textSize(15);
  textAlign(LEFT);
  text(String.format("FPS: %.5f", frameRate), 10, 20);
  text(String.format("TPF: %.5f ms", nanosElapsed/1000000f ), 10, 30);
  nanosElapsed = System.nanoTime() - nanos; //Stop counting time
}

void resizeEvent(){
    screenSize.x = width;
    screenSize.y = height;
    
    // Resize the bubble system
    bs.reSize(env.getVaseBubblePoint().add(new PVector(height/16, -height/16)),
      new PVector(width/16f, height/16f),
      new PVector(width-width/8f, height/1.32f));

    // Resize the pellet system
    ps.reSize(new PVector(0,0),
      new PVector(width/16f, height/16f),
      new PVector(width-width/8f, height/1.32f));
    
    // Resize the office image 
    office.resize(round(screenSize.x), round(screenSize.y));
    
    // Redraw the sand bottom picture
    env.redrawSand();
    // Reposition the trees 
    foliage.reposition();
    // Redistribute the water surface segments 
    water.setSize(new PVector(width/16f, height/6f), new PVector(width-width/8f, height/1.32f));
}

// Spawns pellets when dragging mouse above the aquarium
void mouseDragged() {
  if (mouseY < height/7f && mouseX > width/12f && mouseX  < width - width/12f)
    ps.spawn(new PVector(mouseX, mouseY), 0.4f);
    displayTutorialText = false; // Disable tutorial text after first food dropped;
}
