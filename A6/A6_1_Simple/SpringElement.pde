/*
  Simple rotational Spring-Damper system -- The Spring Element
  
  This *Little* class is a segment of a flower. 
  The flower element is affected by the following effects
    Wind 
    Spring 
    Damping 
    2nd Newton's law from the segments above it.
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */


class SpringElement{
  // Coefficients
  static final float windForceMult = 0.030f;
  static final float rDampingC =  3f; 
  static final float rSpringC  = .9f;
  static final float density = 0.04f;
  
  // Radi
  static final float stemBaseRadius = 10f;
  static final float stemTipRadius =  4f;
  static final float flowerRadius = 20f; 
  
  // Debug flag 
  static final boolean debug = false;

  // Screen position 
  PVector absolutePosition;
  
  // Physical units 
  float angle = 0;
  float rVel = 0;
  float rForce = 0;
  float branchMass = 0;
  float radius;
  
  // Type booleans 
  // TODO: use a ENUM 
  boolean isFlower = false;
  boolean isLeaf   = false; 
  
  // Forces as fields for debug 
  float damping = 0; 
  float spring = 0; 
  float nextForce = 0;
  float wind;
  
  // -- Constructor 
  SpringElement(float a, float v, int j){
    angle = a; 
    rVel = v; 
    absolutePosition = new PVector(0,0);
    
    // Type determination using index
    isFlower = j == flowerHeight  - 1;
    isLeaf = j % 4 == 0; 
    
    // Radius dependent on type 
    if(isFlower)
      radius = flowerRadius;
    else if(isLeaf)
      radius = calculateStemRadius(j) * 1.2;
    else  
      radius = calculateStemRadius(j);
    
    // Formula: PI * rad^2 
    // Get the surface of all the stem segments safe from pi (Distributivity identity of summation)
    for(int x = j; x < flowerHeight -1;x++){
      branchMass += pow(calculateStemRadius(x),2);
    }
    // Get the surface of the flower 
    branchMass += pow(flowerRadius,2);
    // Multiply by the missing pi and density 
    branchMass *= PI * density;
  }
  
  // Helper function to get the radius of a given indexed stem element
  float calculateStemRadius(int index){
     return stemBaseRadius - (stemBaseRadius - stemTipRadius) * index/float(flowerHeight);
  }
  
  // Get the forces speeds and positions up to date
  void update(float prevVel , float nextForce){
    damping = -angle / rSpringC;
    spring  = -rVel * rDampingC; 
    wind    = (noise(absolutePosition.x,absolutePosition.y,timeParameter)  * 2 -1) * windForceMult;
    
    rForce = damping + spring + wind;
    
    this.nextForce = -nextForce;
    rVel  += (rForce - nextForce)/branchMass;
    
    angle -= prevVel;  
    angle += rVel;  
  } 
  
  void display(){
    rotate(angle % TWO_PI);
    // This is a workaround to get the ultimate position using the matrices 
    // This is only used to sample the wind from perlin noise 
    absolutePosition.x = screenX(0,0);
    absolutePosition.y = screenY(0,0);
    
    // Style params 
    strokeWeight(0.5);
    stroke(152,0,0,60);
    
    // Rendering by type
    if(isFlower){
      fill(255,255,0);
      circle(0,0,radius*2);
    }
    
    else if(isLeaf){
      fill(0,255,0);
      quad( 1.6 * radius, -1.3 * radius,
           -1.6 * radius, -1.3 * radius,
           -0.2*radius, radius,
            0.2*radius, radius);
    }
    else{
      fill(0,255,0);
      quad( 0.8 * radius, 1.3 * radius,
           -0.8 * radius, 1.3 *radius,
           -0.7*radius, -radius,
            0.7*radius, -radius);
    }
    
    // Debug force lines
    // This quintuples the amount of draw calls, meaning the framerate
    if(debug){
      strokeWeight(3);
      // Spring force (TEAL)
      stroke(0,255,255);
      line(0,12,spring*100f,12);
      // Damping force (GREEN)
      stroke(0,255,0);
      line(0,14,damping*100f,14);
      // 2nd Newton's law regarding the segment that is next (BLUE)
      stroke(0,0,255);
      line(0,16,nextForce*100f,16);
      // Wind (RED)
      stroke(255,0,0);
      line(0,18,wind*100f,18);
      
    }
    
    // Translate to next element
    translate(0,-radius*2);
  }
  
  
  void windEvent(){
    float mult = (width/2f - mouseX) / width * 0.001f ;
    rVel += mult /windForceMult / branchMass;
  }
}
