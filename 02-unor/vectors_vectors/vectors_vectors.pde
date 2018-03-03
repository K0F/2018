
ArrayList vectors;
float rozpal = 10.0;
float C = 0.0;
void setup(){
  size(720,576,P2D);

  vectors = new ArrayList();

  for(float y = 0; y < height; y+=rozpal){
    for(float x = 0; x < width; x+=rozpal){
    float xx = dist(x,y,width/2,height/2);
    float yy = dist(x,y,width/2,height/2);
    float r = 255.0; 
    float g = 255.0;
    float b = 255.0;
      vectors.add(new Vec(width/2,height/2,xx,yy,r,g,b));
    }
  }

}


void draw(){
  background(0);
  for(int i = 0 ; i < vectors.size();i++){
    Vec temp = (Vec)vectors.get(i);
    temp.draw();
  }


}



class Vec{
  PVector dir;
  PVector pos;
  PVector col;
  float speed = 1.0;
  float rot;
  float dev;

  Vec(float x,float y,float xx,float yy, float r,float g,float b){
    pos = new PVector(x,y);
    dir = new PVector(xx,yy);
    col = new PVector(r,g,b);
    C++;
    dev = C;
  }

  void draw(){
    float off = 33.0;
    speed = sin(pos.x+dev)*speed+cos(pos.y+dev)*speed/100.0;
    pushMatrix();
    translate(pos.x,pos.y);
    stroke(col.x,col.y,col.z,33);
    rotate(rot);
    line(off,0,dir.x,dir.y);
    popMatrix();
    rot+=radians(speed);

  }


}
