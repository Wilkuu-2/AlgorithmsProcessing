//PerlinNoise landscape assignement 2.6
//Made by: Daan Doeleman and Arthur van der Torre
landscape line;


float yoff = 0.0;
float yincrement = 0.01;
int x;

int linesCount = 640; // je hebt nog geen 10 planeten, maar wel 10 arrays. door te klikken voeg je planeten toe aan de array
landscape[] lines = new landscape[linesCount];



void setup() {
  size(640, 360);
  background(0, 0, 255);
  noStroke();

  for (int i=0; i<linesCount; i++) {
    lines[i] = new landscape(i);
  }
}

void draw() {

  for (int i=0; i<linesCount-1; i++) {
    //fill(0, 0, 255);
    //rect(0, 0, width, height);
    
    background(0,0,255);
    fill(0, 255, 0);
    lines[i] = lines[i+1];
  }

  for (int i=0; i<linesCount; i++) {
    lines[i].display();
  }

  lines[linesCount-1] = new landscape(linesCount-1);

  fill(150, 150, 150);
  rect(0, 320, width, 50);
  fill(255, 0, 0);
  rect(280, 310, 100, 30);
  rect(305, 290, 50, 30);
  fill(0, 0, 0);
  ellipse(305, 340, 30, 30);
  ellipse(355, 340, 30, 30);
}
