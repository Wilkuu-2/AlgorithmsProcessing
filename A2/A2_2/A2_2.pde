import java.util.Random;

int[] colum = new int[6];
int counter=0;
byte[] randomBytes = new byte[1000100];
int numberRate = 500;


void setup() {
  size(500, 800);
  background(255);

  Random rd = new Random();
  rd.nextBytes(randomBytes);

  for (int t=0; t<5; t++) {
    colum[t] =0;
  }
}


void draw() {

  //randomN();

  columHeight();
  colum();
  grid();
}

// makes the grid
void grid() {
  for ( int j=1; j<=6; j++) {
    line(j*width/6, height, j*width/6, 0);
  }
  for ( int i=1; i < 1000000; i+=pow(10, floor(log(i)/log(10)))) {
    float h = height-(log(i)/log(10)*120);
    line(0, h, width, h);
  }
  fill(255, 60, 120);
}


//makes the pink colums that will shows
void colum() {
  for (int t=0; t<6; t++) {
    //print("["+ (-colum[t]) + "] ");
    rect(0+t*width/6, height, width/6, log(colum[t])/log(10f)*-120);
    //println("t is:", t );
  }
}
// gets a random number fro the array and updates the height of the colum
void columHeight() {
  for (int i = 0; i < numberRate; i++) {
    if (counter>=1000000) {
      noLoop();
    } else {
      int count= min(int(randomBytes[counter]) % 7, 5);
      
      colum[count]++;
      counter+=1;
      println("counter:" + counter);
    }
  }
}


void mouseClicked() {
  int random;
  random = (int) random(1, 6);
  println("random number is:", random  );
}
