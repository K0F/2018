float SLOWDOWN = 0.999733;
float SPEED = 1000.0;
float RAD = 10.0;

int NUM = 500;
ArrayList machines;

int alpha = 25;

void setup(){
  size(1280,720,P2D);

  rectMode(CENTER);
  machines = new ArrayList();

  for(int i = 0 ; i < NUM;i++){
    machines.add(new Machine(i));
  }
  background(0);

}


void draw(){


  for(int i = 0 ; i < machines.size();i++){
    Machine tmp = (Machine)machines.get(i);
    tmp.move();
    tmp.draw();
  }

}


class Machine{
  PVector pos;
  PVector acc;
  PVector vel;
  int id;
  float ddd = 0.0;

  Machine(int _id){
    id = _id;
    pos = new PVector(random(width),random(height));
    acc = new PVector(random(-1.0,1.0),random(-1.0,1.0));
    vel = new PVector(0.0,0.0);

  }

  void move(){
    float x,y;
    x = pos.x;
    y = pos.y;

    pos.add(vel);
    vel = new PVector(0,0);
    vel.add(acc);
    
    attract();
    detract();
    //bounds();

    ddd += dist(pos.x,pos.y,x,y);

  }

  void bounds(){
    if(pos.x>width)
      pos.x = 0;

    if(pos.x<=0)
      pos.x = width-1;

    if(pos.y>height)
      pos.y = 0;

    if(pos.y<=0)
      pos.y = height-1;


  }

  void attract(){

    acc = new PVector(acc.x*SLOWDOWN,acc.y*SLOWDOWN);
    
    int nearest = -1;
    float sofar = 10000.0;

    for(int i = 0 ; i < machines.size();i++){
      if(i!=id){
        Machine other = (Machine)machines.get(i);
        float d = dist(pos.x,pos.y,other.pos.x,other.pos.y);
        
        if(sofar>d){
        sofar = d;
        nearest = other.id;
        }
     }
    };

    Machine other = (Machine)machines.get(nearest);
    acc.x += (other.pos.x-pos.x)/SPEED;
    acc.y += (other.pos.y-pos.y)/SPEED;
    
    stroke(#FFCC00,alpha/2);
    line(other.pos.x,other.pos.y,pos.x,pos.y);
    //acc.x += ((width/2.0)-pos.x)/1000.0;
    //acc.y += ((height/2.0)-pos.y)/1000.0;
  }

  void detract(){

    acc = new PVector(acc.x*SLOWDOWN,acc.y*SLOWDOWN);
    for(int i = 0 ; i < machines.size();i++){
      if(i!=id){
        Machine other = (Machine)machines.get(i);
        float d = pow(dist(pos.x,pos.y,other.pos.x,other.pos.y)+1.0,RAD*1.0);
        acc.x -= ((other.pos.x-pos.x)/d/(float)NUM)*SPEED;
        acc.y -= ((other.pos.y-pos.y)/d/(float)NUM)*SPEED;
      }
    };

  }
  void draw(){
    fill(
    (sin(ddd/SPEED)+1.0)*127.5,
    alpha);

    noStroke();
   // pushMatrix();
   // translate(pos.x,pos.y);
    rect(pos.x,pos.y,3,3);
   // popMatrix();
  }



}
