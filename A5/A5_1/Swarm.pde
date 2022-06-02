/*
  Swarm
    A container for Units
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
    
  ORIGINAL: 
  // The Nature of Code
  // Daniel Shiffman
  // http://natureofcode.com

// Flock class
// Does very little, simply manages the ArrayList of all the boids
*/

class Swarm {
  ArrayList<Unit> units; // An ArrayList for all the boids

  Swarm() {
    units = new ArrayList<Unit>(); // Initialize the ArrayList
  }

  void run() {
    for (Unit b : units) {
      b.run(units);  // Passing the entire list of boids to each boid individually
    }
  }

  void addUnit(Unit b) {
    units.add(b);
  }
  
  void addUnits(int n){
    for(int i = 0; i < n ; i++){
      units.add(new Unit(random(100,width-100), random(100,height-100),0));
    }
  }
    
}
