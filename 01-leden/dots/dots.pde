

float bpm = 115.0/120.0/16.0;
float R = 10.0;

void setup(){
  fullScreen(OPENGL);
  println(dist(0,0,width,height)/(float)width);
}


void draw(){

  background(0);
  float tempo = (millis()/1000.0) * TWO_PI * bpm;
  stroke(255,66);
  for(int y = 0 ; y < width;y+=10){
    for(int x = 0 ; x < width;x+=10){
      float d = pow(dist(width/2,height/2,x,y)/(width/2.0/1.4142135),sin(tempo/32.0)+1.0001);
      float xx=(cos(tempo/d)*R)+x;
      float yy=(sin(tempo/d)*R)+y;
      pushMatrix();
      translate(xx,yy);
      rotate(tempo/d);
      line(0,sin(tempo/d)*(-R),0,sin(tempo/d)*R);
      popMatrix();
    }
  }

}
