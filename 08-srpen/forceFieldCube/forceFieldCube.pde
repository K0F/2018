
int dimm = 10;
ArrayList tensors;
int sc = 10;

void setup(){

  size(640,480,P3D);

  tensors = new ArrayList();

  int c = 0;
  for(int z = 0 ; z < dimm;z++){
    for(int y = 0 ; y < dimm;y++){
      for(int x = 0 ; x < dimm;x++){
        Tensor tmp = new Tensor(new PVector(x*sc,y*sc,z*sc),c);
        tensors.add(tmp);
        c++;
      }
    }
  }

}

void draw(){
  background(0);

  pushMatrix();
  translate(width/2-(dimm*sc/2.0),height/2-(dimm*sc/2.0),-(dimm*sc/2.0));
  rotateY(millis()/10000.0*TWO_PI);
  rotateX(millis()/100000.0*TWO_PI);
  for(int i = 0 ; i < tensors.size();i++){
    Tensor tmp = (Tensor)tensors.get(i);
    tmp.draw();
  }

  popMatrix();

}




class Tensor{

  PVector pos;
  PVector dir;
  float force;
  int _id;

  Tensor(PVector _pos,int _id){
    pos = new PVector(_pos.x,_pos.y,_pos.z);  
    dir = new PVector(random(-PI,PI),random(-PI,PI),random(-PI,PI));
    force = 1.0;

  }

  void draw(){

    stroke(255,120);
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    rotateX(dir.x);
    rotateY(dir.y);
    rotateZ(dir.z);
    box(1);
    line(0,5,0,0);
    popMatrix();

  }




}
