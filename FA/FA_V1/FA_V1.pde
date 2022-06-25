Enviroment env;
Bubblesystem bs;
PImage office;
PVector screenSize; 
long nanosElapsed = System.nanoTime();

void setup() {
  screenSize = new PVector(width,height);
  //fullScreen();
  size(1000, 1000, P2D);
  env = new Enviroment();
  office=loadImage("office.1.png");
  bs = new Bubblesystem(new PVector(width/3.5f, height-height/4.5));
  surface.setResizable(true);
}

void draw() {
  nanosElapsed = System.nanoTime(); // Start counting time
  // Resize
   if(screenSize.x != width || screenSize.y != height){
     screenSize.x = width; 
     screenSize.y = height;
     
     bs.move(new PVector(screenSize.x / 5, screenSize.y - screenSize.y/4));
     office.resize(round(screenSize.x), round(screenSize.y));
   }
  
  image(office, 0, 0);
 

  env.display();
  bs.addParticle();
  bs.run();
  
  
  nanosElapsed = System.nanoTime() - nanosElapsed; //Stop counting time
  fill(0);
  text(String.format("FPS: %.5f", frameRate      ), 10, 20);
  text(String.format("TPF: %.5f ms", nanosElapsed/1000000f ), 10, 30);
}
