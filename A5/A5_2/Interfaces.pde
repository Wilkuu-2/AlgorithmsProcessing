
static interface Force { 
  PVector getForce(SimObject origin, ArrayList<SimObject> other); 
}



interface ISimObjComp{
  boolean compare(SimObject origin, SimObject other);
}
