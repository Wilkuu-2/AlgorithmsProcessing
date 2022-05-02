# Question 1.9
1. An object is a realization of a class, where a class is a blueprint of data and methods that act on this data somehow. 

2. An object variable is a variable for a object of a class, for example a variable named `name` of class `String` holds a `String` object.
This is how object variables are assigned.

```processing
ClassName variableName; //Uninitialized
PVector position = new PVector(0,0); //Initialized 

```

3. A constructor is a method where the code for initialization of objects of a class lives. 

4. A method of a class is some code that acts on or using the object of that class. 

Looking at this example one can see a class called `Counter` that counts using one method and checks for a flag on the second. 
Those methods use the field of the object
```processing
Class Counter{
  int c;
  int limit;
  boolean limitReached = false;
  
  Counter(int start, int limit){
    this.c = start;
    this.limit = limit;
  }
  
  void countUp(int add){
    c++;
    if(c >= limit){
      limitReached = True; 
      c=0;
    }
    
  boolean checkCounterLimit(){
    if(limitReached){
      limitReached = False; 
      return True; 
    }
    return false;
  }

}
```
In this example we can see how to call a method. (Uses the Counter class from above)

```processing
Counter count;
color bg = color(0);

void start(){
  count = new Counter(0, 100); // Calling the constructor using the `new` keyword
}

void draw(){
  if(count.checkCounter){ //Using output of a method that output a value 
    background(255);
  } else{
    background(0);
  }
  count.countUp(); //Counting up using a method
}

```
