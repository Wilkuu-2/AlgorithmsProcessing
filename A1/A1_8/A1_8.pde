/*
  1.8 Prime factors 
  
  Get the highest prime factor from file
  Uses chached primes to save on time 

*/
BufferedReader primefile;
long[] primes = new long[600];

void setup() {
  primefile = createReader("primes.txt");

  int primeC = 0;
  while (primeC < primes.length) {
    
    //Read primes from a file 
    try {
      String l = primefile.readLine();            //Read lline from the file
      String[] primesStrings = l.split("[ ,\n]"); //Split line by either a space or a newline (https://www.w3schools.com/java/java_regex.asp)
      println(primesStrings.length);           
                                               
      for (String pr : primesStrings) {           //Add and parse all numbers in a line 
        primes[primeC] = Long.parseLong(pr);
        primeC ++;
      }
    }
    catch(IOException e) {
      break;
    }
  }
  println(primeC);
}

void draw() {
  long num = 317584931803L ;
  long highest = 0;
  for (long prime: primes) {
    if (num % prime == 0) {
      //println("yes");
      println("the number is divisible by ", prime);
      highest = prime;
    }
  }
  println("The biggest prime divider of "+ num + " is: " + highest);

  noLoop();
}

boolean isPrime(long in) {
  for (long p : primes) {
    if (in/2 < p)
      return false;
    if (p == in)
      return true;
  }
  return false; 
}
