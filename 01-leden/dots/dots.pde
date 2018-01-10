

float bpm = 121.33/120.0;
float R = 10.0;

void setup(){
  fullScreen(P2D);
  println(dist(0,0,width,height)/(float)width);
}


void draw(){

  background(0);
  float tempo = (millis()/1000.0) * TWO_PI * bpm;
  stroke(255,120);
  for(int y = 0 ; y < width;y+=10){
    for(int x = 0 ; x < width;x+=10){
      float d = pow(dist(width/2,height/2,x,y)/(width/2.0/1.4142135),sin(tempo/32.0)+1.0001);
      float xx=(cos(tempo/d)*R)+x;
      float yy=(sin(tempo/d)*R)+y;
      pushMatrix();
      translate(cos(xx/100.0)*xx+width/2,sin(yy/100.0)*yy+height/2);
      rotate(tempo/d);
      line(0,-10,0,10);
      popMatrix();
    }
  }

}
