float tempo = (90/120.0/4);
float pulse;

void setup(){
  fullScreen(OPENGL);
}

void draw(){
  float r = (sin((millis()/1000.0*tempo/2.0)*TWO_PI)+1.0)/2.0;
  float g = (sin((millis()/1000.0*tempo/3.0)*TWO_PI)+1.0)/2.0;
  float b = (sin((millis()/1000.0*tempo/5.0)*TWO_PI)+1.0)/2.0;
  background(r*255,g*255,b*255);
}
