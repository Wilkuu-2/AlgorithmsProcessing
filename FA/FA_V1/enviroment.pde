/*
  Enviroment
  
  Container for the background elements
  
  Copyright 2022 Jakub Stachurski and Jules Verhagen
  
  - Im not that proud for this piece of the codebase -Jakub
*/

class Enviroment {
  float sandDensity= 0.5;
  float sandDuneHeight = 40f;
  color[] sandColors = {#AFAE9F, #DED99A, #EEE357,#CFCE6F,#E8DC3D,#DED99A};
  PImage vase;
  PGraphics sand;
  PVector sandPos;
  long backNanos = System.nanoTime();
  long frontNanos = System.nanoTime();

  Enviroment( ) {
    vase=loadImage("vase.png");
    redrawSand(); 
  }




 void redrawSand(){
    //----------------sand---------------------
    sandPos = new PVector(width/15, height-height/5);
    PVector sandSize = new PVector(width-width/7.5, height * (1f/5f - 1f/13f));
    
    sand = createGraphics(round(sandSize.x), round(sandSize.y + sandDuneHeight));
    sand.beginDraw();
    sand.fill(sandColors[0]);
    for (float i=0; i<sandSize.x; i += sandDensity) {
      for (float j=0; j<sandSize.y; j += sandDensity) {
        float z = noise(i*0.1f,j*0.2f) * (sandColors.length -1);
        
        sand.set(round(i + noise(0,i,j) * sandDuneHeight * sandDensity),
                 round(j + noise(0,j,i) * sandDuneHeight * sandDensity),
                  sandColors[round(z)]);
      }
    }
    sand.endDraw();
 }


  void display() {
    backNanos = System.nanoTime();
    noStroke();
    //---------------aquarium glime------------------
    fill(169, 213, 255, 155);
    rect(width/20, height/10f, width-width*2/20, height-height*2/16, 10);

    //----------------sand---------------------
    image(sand, sandPos.x, sandPos.y - sandDuneHeight/2);
    //------------------vase-------------
    float ARatio = vase.width/ vase.height;

    image(vase, width/10f, height-height/3.2, ARatio * height/4f, height/4f);
    
    backNanos = System.nanoTime() - backNanos;

  }
  
  PVector getVaseBubblePoint(){
    float ARatio = vase.width/ vase.height;
    return new PVector(width/10f + ARatio * height/9f , height-height/3.2 + height/7f);
  }
  
  void displayFront(){
    frontNanos = System.nanoTime();
    noStroke();
        //----------------aquarium glass--------------
    fill(125, 191, 255, 90);
    rect(width/16, height/10f, width-width*2/16, height-height*2/12, 10);

    //--------------------desk-------------------
    fill(198, 162, 126);
    rect(0, height-height/20, width, height);
    
    frontNanos = System.nanoTime() - frontNanos;
  }
}
