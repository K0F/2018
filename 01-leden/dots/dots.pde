

float bpm = 121.33/120.0;
float R = 50.0;

void setup(){
  size(480,480,P2D);

}


void draw(){

  background(0);
  stroke(255);
  float tempo = millis()/1000.0*TWO_PI*bpm;
  for(int y = 0 ; y < width;y+=2){
    for(int x = 0 ; x < width;x+=2){
  float d = pow(dist(width/2,height/2,x,y),0.2);
      float xx=(cos(tempo/d)*R/d)+x;
      float yy=(sin(tempo/d)*R/d)+y;
      point(xx,yy);
    }
  }

}
