/*
  Foliage
 
   A simple Array container for SpringTrees
 
 
   Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

class Foliage {
  long updateNanos = System.nanoTime();
  long drawNanos   = System.nanoTime();
  SpringTree[] trees;

  SpringNode root;
  static final float angleV  = PI/30f;
  static final float angVelV = PI/4444f;
  static final float timeFactor = 0.0001;
  static final int   treeAmount = 2;

  float zoneHeight;
  float zoneBegin;
  float zoneSize;


  Foliage() {
    zoneHeight = height-height/7f;
    zoneBegin  = width*0.35;
    zoneSize   = width*0.25;



    trees = new SpringTree[treeAmount];
    for (int i = 0; i < treeAmount; i++ )
      trees[i] = new SpringTree(new PVector(zoneBegin + float(i+1) / float(1+treeAmount) * zoneSize, zoneHeight + random(-40+40*i, 30*i)),
        0, // Starting angle of the root node
        angleV, // Variation in starting velocity for each node
        angVelV, // Variation in starting angular velocity for each node
        round(random(2, 2)), // Amount of root branches
        round(random(4, 6)), // Amount of nodes before a root branch will branch off
        round(random(2, 3)), // Amount of times the root branches branch off
        round(random(5, 10))); // Amount of nodes added to the branch agter branching off
  }

  void update() {
    float timeParameter = millis() * timeFactor;
    updateNanos = System.nanoTime();
    // Start updating recursively
    for (SpringTree t : trees)
      t.update(timeParameter);

    updateNanos = System.nanoTime() - updateNanos; //Stop counting time
  }
  void display() {
    drawNanos = System.nanoTime();
    for (SpringTree t : trees)
      t.display();

    drawNanos = System.nanoTime() - drawNanos; //Stop counting time
  }

  void reposition() {
    zoneHeight = height-height/7f;
    zoneBegin  = width*0.35;
    zoneSize   = width*0.25;


    for (int i = 0; i < treeAmount; i++ )
      trees[i].move(new PVector(zoneBegin + float(i+1) / float(1+treeAmount) * zoneSize, zoneHeight));
  }
}
