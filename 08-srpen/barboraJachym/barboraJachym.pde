import processing.pdf.*;

/**
Coded by Kof @ 
Sun Aug  5 08:34:59 CEST 2018

   ,dPYb,                  ,dPYb,
   IP'`Yb                  IP'`Yb
   I8  8I                  I8  8I
   I8  8bgg,               I8  8'
   I8 dP" "8    ,ggggg,    I8 dP
   I8d8bggP"   dP"  "Y8ggg I8dP
   I8P' "Yb,  i8'    ,8I   I8P
  ,d8    `Yb,,d8,   ,d8'  ,d8b,_
  88P      Y8P"Y8888P"    PI8"8888
                           I8 `8,
                           I8  `8,
                           I8   8I
                           I8   8I
                           I8, ,8'
                            "Y8P'
*/

int no = 0;
int num = 22;
ArrayList shapes;
PVector center;
int[] hues = {42,360};
int[] sats = {0};
int[] brights = {0,120,200};
PImage front;
float alpha = 1;
//////////////////////////////////////////////////

void setup(){
  size(600,900);
  colorMode(HSB,360);
  front = loadImage("front.png");
  textMode(SHAPE);
  textFont(createFont("Calluna-Regular.otf",16));
  center = new PVector(0,0);
  regenerate();
}


void regenerate(){
  alpha = 1;
  shapes = new ArrayList();
  for(int i = 0 ; i < num;i++)
    shapes.add(new Shape(no,i));

  no++;
}



void draw(){

  
  background(360);
  beginRecord(PDF,"render/pozvanka_"+nf(no,2)+".pdf");

  resetMatrix();
  translate(width/2.0,height/2.5);

//scale(1.5);
 for(int i = 0 ; i < shapes.size();i++){
    Shape tmp = (Shape)shapes.get(i);
    tmp.drawA();
  }
for(int i = 0 ; i < shapes.size();i++){
    Shape tmp = (Shape)shapes.get(i);
    tmp.drawB();
  }


  
resetMatrix();
  image(front,0,0,width,height);
  fill(0,0,0);
  //text(no+" / 60",width-100,height-30);

    if(no<=100)
      endRecord();
    else
      exit();

    regenerate();
}

//////////////////////////////////////////////////


class Shape{
  int type;
  float rot;
  PVector pos;
  color col;
  int seed;
  int id;
  float lon,lat;
  float w,h;

  Shape(int _id,int _seed){

    id = _id;
    seed = _seed;

    seed = (seed*12345+id);

    generate();

  }

  void generate(){
    randomSeed(seed);
    lon = 4*(int)random(1,10);
    lat = 4/1.6180339887*(int)random(1,10);
    pos = new PVector(((int)random(0,3)*lon),((int)random(0,10)*lat));
    rot = radians(360/5.0*((int)random(-2,2)));
    col = color(hues[(int)random(hues.length)],sats[(int)random(sats.length)],brights[(int)random(brights.length)]);
    type = (int)random(100);
    w = lon*5;//(int)random(1,5)*lon;
    h = lat*5;// (int)random(1,5)*lat;


  }

  void drawA(){

    alpha = 0.75;
    //pushMatrix();
    rotate(rot);
    translate(pos.x/4.0,0);
    fill(col,map(sqrt(w*h),300,1,0,360)*alpha);
     stroke(0,120);

    if(type<5){
      noStroke();
      ellipseMode(CENTER);
      ellipse(0,0,w,w);
    }else if(type >=5 && type <=10){
      line(-w*2,0,h,0); 
    }else if(type >=11 && type <=20){
      noStroke();
      rect(0,0,-w,h/2.0);
    }else{
    stroke(0,30);
      line(0,0,w*1.5,0);
    }

    //popMatrix();

  }


  void drawB(){

    //pushMatrix();
    rotate(rot);
    translate(pos.x/4,0);
    //fill(col,map(sqrt(w*h),300,1,0,360)*alpha);
    noFill();
    stroke(0,120);

    if(type<5){
      noStroke();
      ellipseMode(CENTER);
      ellipse(0,0,w*2,w*2);
    }else if(type >=5 && type <=10){
      line(-w*4,0,-h,0); 
    }else if(type >=11 && type <=20){
      noStroke();
      rect(0,0,-w*1.1,h/2.0*1.1);
    }else{
      line(0,0,-w*1.5,0);
    }

    //popMatrix();

  }





}

