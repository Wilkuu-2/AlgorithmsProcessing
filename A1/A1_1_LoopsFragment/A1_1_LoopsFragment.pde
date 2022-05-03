/*
  1.1 loop fragmants
  "
      For the array of characters below write methods that execute the descriptions of 1.1.1.-1.1.5.
      
   1.1.1.  writes the content of the array on the Processing window, letter by letter 
   1.1.2.  writes the content of the array on the Processing window, backwards order, i.e. starting with the last 
   1.1.3.  counts how many occurrences of the letter ‘E’ are contained in the array 
   1.1.4 decides whether the letter 'O' is contained in the array. 
   1.1.5.  decides whether the array form a palindrome, i.e. reading from beginning gives the same “word” as reading from the end. An example for a palindrome is “ANNA”. 
           For this exercise do not use the reverse method from Java - the idea is that you find an 
           efficient way to decide that 
           "  from :(https://canvas.utwente.nl/courses/10160/pages/planning-and-material?module_item_id=320493)
           
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

void draw() {
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
  for (int i = 0; i < localWord.length; i++) {
    print(localWord[i]);
    // fill in the loop
  }
  println();
  // fill in the loop
}

// this method only draws something, therefore, it has void as result type
void printBackwards( char[] localWord) {
  for (int i = localWord.length -1; i >=0; i--) {
    print(localWord[i]);
    // fill in the loop
  }
  println();
  // fill in the loop
}

// this method has as result an integer
int numberOfEs (char[] localWord) {
  int result = 0;

  for (int i = 0; i < localWord.length; i++) {

    if (localWord[i]=='E') {
      result=result+1;
    }

    // fill in the loop
  }


  return result;
  // fill in the loop
}

// this method has as result a boolean
boolean isPalindrome(char[] localWord) {
  boolean result = true;
  // fill in the loop
  return result;
}

// this method takes two parameters and has as result a boolean
boolean containsLetter ( char[] localWord, char searchLetter) {
  for (int i = 0; i < localWord.length; i++) {
    if (localWord[i] == searchLetter)
      return true;
  }
  return false;
}
