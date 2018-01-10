

float bpm = 121.33/120.0;
float R = 10.0;

void setup(){
  size(480,480,P2D);

}


void draw(){

  background(0);
  stroke(255);
  float tempo = (millis()/1000.0) * TWO_PI * bpm;
  for(int y = 0 ; y < width;y+=5){
    for(int x = 0 ; x < width;x+=5){
      
      float xx=(cos(tempo)*R)+x;
      float yy=(sin(tempo)*R)+y;
      
      point(xx,yy);
    }
  }

}
