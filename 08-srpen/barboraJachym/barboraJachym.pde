import processing.pdf.*;

int no = 0;
int num = 23;
ArrayList shapes;

int[] hues = {43,360};

void setup(){
  size(900,1050);
  colorMode(HSB,360);

  textFont(createFont("Calluna",16));
  regenerate();
}


void regenerate(){


  shapes = new ArrayList();
  for(int i = 0 ; i < num;i++)
    shapes.add(new Shape(no,i));

  no++;
}



void draw(){

  background(360);
  
  beginRecord(PDF,"generator_"+nf(no,2)+".pdf");

  resetMatrix();
  translate(width/2,height/2);

  for(int i = 0 ; i < shapes.size();i++){
    Shape tmp = (Shape)shapes.get(i);
    tmp.draw();
  }

  resetMatrix();
  fill(0,0,0);
  text(no+" / 60",width-100,height-30);


    if(no<=60)
      endRecord();
    else
      exit();

    regenerate();
}







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
    lon = 3*(int)random(1,10);
    lat = 3/1.6180339887*(int)random(1,10);
    pos = new PVector(((int)random(0,3)*lon),((int)random(0,10)*lat));
    rot = radians(360/7.0*((int)random(-3,3)));
    col = color(hues[(int)random(hues.length)],random(120,360),random(50,150));
    type = (int)random(10);
    w = lon*5;//(int)random(1,5)*lon;
    h = lat*5;// (int)random(1,5)*lat;
  }

  void draw(){

    //pushMatrix();
    rotate(rot);
    translate(pos.x,0);


    fill(col,map(sqrt(w*h),200,1,0,360));

    if(type==0){
      noStroke();
      ellipseMode(CENTER);
      ellipse(0,0,w,w);
    }else if(type >=1 && type <=4){
      stroke(0,120);
      line(-w*2,0,h,0);
    }else if(type >=5 && type <=7){
      noStroke();
      rect(0,0,-w,h/2.0);
    }else{
    ;
    }

    //popMatrix();

  }





}
