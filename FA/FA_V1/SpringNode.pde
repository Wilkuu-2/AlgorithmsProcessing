
static int springNodeCount = 0;

class SpringNode {
  static final boolean debug = false;
  static final float density = 0.1f;
  static final float windForceMult = 0.030f;
  static final float springConst = 0.3f;
  static final float resistanceConst = 5f;
  static final float collisionForceMult = 10f;
  float rad =  9f;
  float individMass = PI * pow(rad, 2);

  // 
  float angle = 0;
  float angVelocity = 0;
  float force = 0;

  // Forces
  float spring;
  float damping;
  float childrenForce;
  float wind;
  float collision; 

  // Identifiers 
  int id;                 //Global id
  int branchId = 0;       //Id on the parent
  int branchCounter = 0;  //Amount of children

  PVector absPos;
  boolean deleteMe = false;
  SpringNode parent;
  ArrayList<SpringNode> children;
  
  // Constructor
  SpringNode(float angle, float angVel) {
    this.angle = angle;
    this.angVelocity = angVel;
    children = new ArrayList<SpringNode>();
    id = springNodeCount++;
    branchId = 0;
    absPos = new PVector(0, 0);
  }

  // Add a child to this node
  void addChild(SpringNode node) {
    children.add(node);
    node.setParent(this);
    branchCounter++;
  }
  
  // Sets the parent of this node
  void setParent(SpringNode parent) {
    this.parent = parent;
    branchId = parent.branchCounter;
  }

  //  Adds a node to a random node without a child 
  void AddToRandomChildlessNode(SpringNode child) {
    getRandomChildlessNode().addChild(child);
  }
  
  // Adds a node to a random node 
  void AddToRandomNode(SpringNode child) {
    getRandomNode().addChild(child);
  }

  // Gets random node without children
  SpringNode getRandomChildlessNode() {
    ArrayList<SpringNode> nodes = getAllChildlessNodes();
    return nodes.get(round(random(0, nodes.size()-1)));
  }

  // Gets a random node form below this node
  SpringNode getRandomNode() {
    ArrayList<SpringNode> nodes = getAllNodesBelow();
    return nodes.get(round(random(0, nodes.size()-1)));
  }

  // Gets all the nodes without a child 
  ArrayList<SpringNode> getAllChildlessNodes() {
    ArrayList<SpringNode> nodes = new ArrayList<SpringNode>();


    if (children.size() < 1) {
      nodes.add(this);
      return nodes;
    }

    for (SpringNode child : children)
      nodes.addAll(child.getAllChildlessNodes());

    return nodes;
  }

  // Gets all the nodes connected to this branch including itself
  ArrayList<SpringNode> getAllNodesBelow() {
    ArrayList<SpringNode> nodes = new ArrayList<SpringNode>();
    nodes.add(this);
    for (SpringNode child : children) {
      nodes.addAll(child.getAllNodesBelow());
    }
    return nodes;
  }
   
  // Add up all the masses since this is all that gets rotated 
  float getFullBranchMass() {
    float totalMass = 0;
    for (SpringNode node : getAllNodesBelow())
      totalMass += node.individMass;
    return totalMass;
  }

  void update(float timeParameter) {
    // Update all the children
    for (SpringNode c : children) {
      c.update(timeParameter);
    }
    
    // Dynamic behavior when not root 
    if (parent != null) {
      
      // Second newtons law 
      childrenForce = 0;
      for (SpringNode c : children) {
        childrenForce += c.force;
      }
      
      // Physical Forces 
      damping = -angVelocity * resistanceConst;
      wind    = (noise(absPos.x, absPos.y, timeParameter)  * 2 -1) * windForceMult;
      spring =  -(angle) / springConst;
      collision = collision(force);

      // Add forces 
      force = damping+spring + wind + collision;
      
      // Get acceleration and add it to the velocity and add velocity to angle
      angVelocity +=  (force - childrenForce) / getFullBranchMass();
      
      angle += angVelocity;
      // Inherit angular velocity
      angle-= parent.angVelocity;
      
      
      children.removeIf(c -> c.deleteMe);
      branchCounter = children.size();
    }
  }

  void display() {
    // Get offset for displaying the
    float targetAngleOffset = 0;
    if (parent != null) {
      targetAngleOffset = (float(branchId +1) * PI) / float(parent.children.size() + 1) - PI/2f;
    }

    rotate(angle + targetAngleOffset);
    strokeWeight(1);
    stroke(0);

    if (parent != null) {
      translate(0, - parent.rad - rad);
    }

    // This is a workaround to get the ultimate position using the matrices
    // This is only used to sample the wind from perlin noise
    absPos.x = screenX(0, 0);
    absPos.y = screenY(0, 0);



    if (children.size() == 0) { // Draw a flower
      fill(255, 255, 0, 180);
      circle(0, 0, rad*2.5);
    } else {                   //Draw a stem
      fill(0, 255, 0, 200);
      quad(rad, -rad,
        -rad, -rad,
        -rad/10f, rad*1.6f,
        rad/10f, rad*1.6f);
    }

    // Debug force lines
    // This quintuples the amount of draw calls, meaning the framerate
    if (debug) {
      strokeWeight(3);
      // Spring force (TEAL)
      stroke(0, 255, 255);
      line(0, 12, spring*100f, 12);
      // Damping force (GREEN)
      stroke(0, 255, 0);
      line(0, 14, damping*100f, 14);
      // 2nd Newton's law regarding the segment that is next (BLUE)
      stroke(0, 0, 255);
      line(0, 16, childrenForce*100f, 16);
      // Wind (RED)
      stroke(255, 0, 0);
      line(0, 18, wind*100f, 18);
    }

    for (SpringNode c : children) {
      if (children.size() > 1)
        pushMatrix();
      c.display();
      if (children.size() > 1)
        popMatrix();
    }
  }
  
  float collision(float force){
    if(absPos.mag() > 1 && (absPos.x < width/12f || absPos.x > width - width/12f)){
      deleteMe = true; 
    }
    
    if(absPos.x < width/10f){
      return abs(pow(3,(absPos.x - width/10f)) *collisionForceMult) + abs(force);
    }
    else if(absPos.x > width - width/10){
      return -abs(pow(3,absPos.x - width + width/10f) *collisionForceMult) - abs(force);
    }
    else{
      return 0;
    }
    
  }
}
