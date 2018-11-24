import oscP5.*;

import supercollider.*;


ArrayList sequences;
float tempo = 1.0;
float sel = 0;
int r = 5;
float offset;

void setup(){
  size(320,240);
  frameRate(60);
  sequences = new ArrayList();
  sequences.add(new Sequence("kick",32));
}


void draw(){
  if(frameCount==0)
    offset = millis();

  float now = (millis()-offset);

  background(0);

  for(int i = 0;i < sequences.size();i++){
    Sequence s = (Sequence)sequences.get(i);
    s.draw();
  }
}

class Sequence{
  String name;
  int length;
  int slots[];
  PVector pos;

  Sequence(String _name,int _length){
    name = _name+"";
    length = _length;
    slots = new int[length];
    pos = new PVector(0,sequences.size()*r);
    for(int i = 0 ; i < length;i++)
      slots[i] = 0;
  }

  void send(){
    Synth synth = new Synth(name);
    synth.create();
  }

  void draw(){
    pushStyle();
    stroke(255);
    fill(255);
    pushMatrix();
    translate(pos.x,pos.y);
    text(name,-r,0);
    for(int i = 0 ; i < slots.length;i++){

      if(slots[i]==1){
        fill(250);
      }else{
        noFill();
      }

      rect(i*r,0,r,r);
    }
    popMatrix();
    popStyle();

  }
}
