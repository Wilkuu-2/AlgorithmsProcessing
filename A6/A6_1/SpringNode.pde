
static int springNodeCount = 0; 

class SpringNode {
  static final boolean debug = true;
  static final float density = 4f;
  float rad =  10f;
  float mass = PI * pow(rad, 2);
  float springConst = 1f;
  float resistanceConst = 1.5f;

  float angle = 0;
  float angVelocity = 0;
  float force = 0;

  float spring;
  float damping; 
  float childrenForce;

  int id;

  SpringNode parent;
  ArrayList<SpringNode> children;

  SpringNode(SpringNode previous, float angle, float angVel) {
    parent = previous;
    this.angle = angle;
    this.angVelocity = angVel;
    children = new ArrayList<SpringNode>();
    id = springNodeCount++; 
  }

  ArrayList<SpringNode> getChildren() {
    return children;
  }

  SpringNode getParent() {
    return parent;
  }

  void addChild(SpringNode node) {
    children.add(node);
    node.setParent(this);
  }

  void setParent(SpringNode parent) {
    this.parent = parent;
  }

  void AddToRandomChildlessNode(SpringNode child) {
    getRandomChildlessNode().addChild(child);
  }
  void AddToRandomNode(SpringNode child) {
    getRandomNode().addChild(child);
  }

  SpringNode getRandomChildlessNode() {
    ArrayList<SpringNode> nodes = getAllChildlessNodes();
    return nodes.get((int)random(0, nodes.size()-1));
  }
  
  SpringNode getRandomNode(){
    ArrayList<SpringNode> nodes = getAllNodesBelow();
    return nodes.get((int)random(0, nodes.size()-1));
  }

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
  
  
  ArrayList<SpringNode> getAllNodesBelow(){
    ArrayList<SpringNode> nodes = new ArrayList<SpringNode>();
    nodes.add(this);
    for(SpringNode child : children){
      nodes.addAll(child.getAllNodesBelow());
    } 
    return nodes;
  }

  void update1() {
    for (SpringNode c : children) {
      c.update1();
    }
    
    childrenForce = 0;
    for (SpringNode c : children) {
      childrenForce += c.force;
    }
    
    damping = -angVelocity * resistanceConst;
    spring =  -angle / springConst;
  
    
    force = damping+spring;
    
    
    angVelocity +=  (force - childrenForce) / mass;
    angle += angVelocity;
    if(parent != null){
      angle-= parent.angVelocity;
    }
    //angle = (abs(angle) % TWO_PI) * angle/abs(angle); 
     if(debug){
       if(id == 0)
         println();
       print(String.format("[%d] D%f S%f C%f V%f A%f  ", id , damping, spring, childrenForce, angVelocity ,angle));
     }
    

   
  }
  void display() {

    pushMatrix();
    rotate(angle);
    strokeWeight(1);
    stroke(0);
    fill(255, 255, 0, 100);
    if(parent != null){
    translate(parent.rad + rad,0);
    }
    circle(0, 0, rad*2);
    
    if(debug){
      strokeWeight(3);
      stroke(255,0,0);
      line(0,0,0,angVelocity*1000f);
      stroke(0,255,255);
      line(-5,0,-5,spring*1000f);
      stroke(0,255,0);
      line(-5,0,-5,damping*1000f);
      stroke(0,0,255);
      line(-10,0,-10,childrenForce*1000f);
    }

    for (SpringNode c : children) {
      c.display();
    }

    popMatrix();
  }
}
