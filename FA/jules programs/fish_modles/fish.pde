class Fish {
  PVector location;
  float r, counter;
  Fish() {
    location = new PVector(width/2, height/2);
    r = 20;
  }


  void display() {


    float theta=radians(counter);
    fill(200, 100);
    stroke(255);
    pushMatrix();

    translate(location.x, location.y);
    fill(255);
    rotate(theta);
    //--------------------moddlee 2-------------------------------------

    //fill(255,0,0);
    //circle(0, r*2, 88);
    //fill(255);
    //beginShape(TRIANGLES);
    //vertex(0, -r*2);
    //vertex(-r*2, r);
    //vertex(r*2, r);
    //endShape();

    //beginShape(TRIANGLES);
    //vertex(2*r, r);
    //vertex(r*5, r*4);
    //vertex(r*2, r*3);
    //endShape();

    //beginShape(TRIANGLES);
    //vertex(-2*r, r);
    //vertex(-r*5, r*4);
    //vertex(-r*2, r*3);
    //endShape();

    //beginShape(TRIANGLES);
    //vertex(0,r*4.4);
    //vertex(-r*4, r*7);
    //vertex(r*4, r*7);
    //endShape();
    ////fill(0,0,255);

    //beginShape(TRIANGLES);
    //vertex(r*2,-r*2);
    //vertex(r, 0);
    //vertex(r*2, r);
    //endShape();
    //-----------------------moddlle 3 -----------------------------------
    circle(0, r, 60);
    fill(255);

    fill(0, 0, 255);
    beginShape(TRIANGLES);
    vertex(r, r);
    vertex(r*4, r*4);
    vertex(r*1, r*3);
    endShape();

    beginShape(TRIANGLES);
    vertex(-r, r);
    vertex(-r*4, r*4);
    vertex(-r*1, r*3);
    endShape();
    fill(255);


    beginShape(TRIANGLES);
    vertex(0, r*2.2);
    vertex(-r*2, r*5);
    vertex(r*2, r*5);
    endShape();
    //fill(0,0,255);
    fill(255, 155);
    ellipse(r, -r*0.5, 20, 50);
    ellipse(-r, -r*0.5, 20, 50);
    fill(255);
    circle(0, 2*r, 60);

    fill(0);
    noStroke();
    circle(0, 1, r);
    popMatrix();
  }
  void increse() {


    if (counter<360) {
      counter++;
    } else {
      counter=0;
    }
  }
}
