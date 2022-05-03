import java.lang.Math;
int[] colum = new int[6];
int counter=0;


void setup() {
  size(500, 800);
  background(255);


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


void grid() {
  for ( int j=1; j<=6; j++) {
    line(j*width/6, height, j*width/6, 0);
  }
  for ( int i=1; i < 1000000; i+=pow(10,floor(log(i)/log(10)))){
    float h = height-(log(i)/log(10)*150);
    line(0,h,width,h);
  }
  fill(255, 60, 120);
}


//void randomN() {
//  int random;
//  for ( int i = 0; i <= 6; i++) {
//    random = (int) random(1, 6);
//  }
//}

void colum() {
  for (int t=0; t<6; t++) {
    print("["+ (-colum[t]) + "] ");
    rect(0+t*width/6, height, width/6, log(-colum[t])/log(10f)*-150);
    //println("t is:", t );
  }
}

void columHeight() {

  if (counter==1000000) {
    noLoop();
  } else {
    int count=(int)random(0, 6);
    colum[count]-=1;
    counter+=1;
    println("counter:" + counter);
  }
 
}
