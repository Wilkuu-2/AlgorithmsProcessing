// program fragment for assignemt 1.1 of Algorithms in Creative Technology


void draw(){
  // this is an array of characters
  char [] word = { 'H', 'E', 'L', 'L', 'O', ' ', 'U', 'N', 'I', 'V', 'E', 'R', 'S', 'I', 'T', 'Y', '!'};
  //char [] word = {'R', 'A', 'C', 'E', 'C', 'A', 'R'}; // to test the palindrome method
  
  printForward(word); // method call
  printBackwards(word); // method call
  println( numberOfEs(word)); // call a method that returns a result and print that
  println( isPalindrome(word)); // call a method that returns a result and print that
  println( containsLetter(word, 'O')); // note, that this method has two very different parameters!
  
  noLoop(); // execute this draw methid only once
}

// this method only draws something, therefore, it has void as result type
void printForward ( char[] localWord) {
  
  // fill in the loop
  
}

// this method only draws something, therefore, it has void as result type
void printBackwards( char[] localWord) {
  
   // fill in the loop
   
}

// this method has as result an integer
int numberOfEs (char[] localWord) { 
  int result = 0;
  // fill in the loop
  return result; 
}

// this method has as result a boolean
boolean isPalindrome(char[] localWord) {
  boolean result = true;
  // fill in the loop
  return result;
}

// this method takes two parameters and has as result a boolean
boolean containsLetter ( char[] localWord, char searchLetter) {
  for(int i = 0; i < localWord.length; i++) {
    if(localWord[i] == searchLetter) 
      return true;
  }
  return false;
}

 
