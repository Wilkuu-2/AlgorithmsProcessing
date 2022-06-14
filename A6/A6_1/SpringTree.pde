/*
 SpringTree
 This is a container class for a tree of spring node.
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */


class SpringTree {
  private PVector position;
  private SpringNode root;

  SpringTree(PVector pos, float angle ,float angleVar, float angVelVar, int rootBranches, int rootBranchStartLength, int branchoffAmount, int branchIntervalFill) {
    position = pos; 
    
    root = new SpringNode(null, angle, 0);
    root.rad = 30f;

    for (int x = 0; x < rootBranches; x ++) { // Add branches from the root
      SpringNode rootBranch = new SpringNode(null, random(-angleVar, angleVar), random(-angVelVar, angVelVar));
      
      // Give the root branch space by filling the branch with nodes
      for(int y = 0; y < rootBranchStartLength; y ++)
        rootBranch.AddToRandomChildlessNode(new SpringNode(null, random(-angleVar, angleVar), random(-angVelVar, angVelVar)));
      
      root.addChild(rootBranch);
      
      //Branch off 
      for (int y = 0; y < branchoffAmount; y ++) { 
        // Create a branchoff at any spot on the root branch
        SpringNode secondaryBranch = rootBranch.getRandomChildlessNode();
        secondaryBranch.addChild(new SpringNode(null, random(-angleVar, angleVar), random(-angVelVar, angVelVar)));
        secondaryBranch.addChild(new SpringNode(null, random(-angleVar, angleVar), random(-angVelVar, angVelVar)));
        // Fill with nodes in between branching off 
        for(int z = 0; z < branchIntervalFill; z++)
          secondaryBranch.AddToRandomChildlessNode(new SpringNode(null, random(-angleVar, angleVar), random(-angVelVar, angVelVar)));
         
      }
    }
  }
  
  
  void display(){
    pushMatrix();
    translate(position.x,position.y);
    root.display();
    popMatrix();
  }
  void update(){
    root.update(); 
  }
}
