
/*
  Template
 Sample text
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

// -- GLOBALS

SpringTree[] trees;

SpringNode root;
static final float angleV  = PI/30f;
static final float angVelV = PI/4444f;
static final float timeFactor = 0.0001;
static final int   treeAmount = 3;
float timeParameter = millis() * timeFactor;
long nanosElapsed = System.nanoTime();



// -- INIT
void setup() {
  size(800, 800, P2D);
  frameRate(60);
  trees = new SpringTree[treeAmount];
  for (int i = 0; i < treeAmount; i++ )
    trees[i] = new SpringTree(new PVector(float(i+1) / float(1+treeAmount) * width, height -10),
                              0,                   // Starting angle of the root node 
                              angleV,              // Variation in starting velocity for each node
                              angVelV,             // Variation in starting angular velocity for each node
                              round(random(2,4)),  // Amount of root branches 
                              round(random(3,6)),  // Amount of nodes before a root branch will branch off 
                              round(random(5,8)),  // Amount of times the root branches branch off
                              round(random(4,6))); // Amount of nodes added to the branch agter branching off 
}


// -- Every Frame
void draw() {
  nanosElapsed = System.nanoTime(); // Start counting time

  //Background drawing
  background(100);
  // Update parameter for the noise
  timeParameter = millis() * timeFactor;
  // Start updating recursively
  for (SpringTree t : trees)
    t.update();

  for (SpringTree t : trees)
    t.display();


  // Draw the nodes
  nanosElapsed = System.nanoTime() - nanosElapsed; //Stop counting time
  fill(0);
  text(String.format("FPS: %.5f", frameRate      ), 10, 20);
  text(String.format("TPF: %.5f ms", nanosElapsed/1000000f ), 10, 30);
}
