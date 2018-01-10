

float bpm = 121.33;
float R = 5;

void setup(){
  size(480,480);

}


void draw(){

  background(0);
  stroke(255);
  float tempo = millis()/1000.0*TWO_PI*bpm;
  for(int y = 0 ; y < width;y+=5){
    for(int x = 0 ; x < width;x+=5){
  float d = dist(mouseX,mouseY,x,y);
      float xx=(sin(tempo/d)*R)+x;
      float yy=(sin(tempo/d)*R)+y;
      point(xx,yy);
    }
  }

}
