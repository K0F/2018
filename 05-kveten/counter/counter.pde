

float time = 0;

void setup(){
  size(1600,320,P2D);
}


void draw(){
  
  time = millis();
  float slope = map(mouseX,0,width,0.1,8.0);
  float speed = map(mouseY,0,height,1000.0,1.0);

  for(int i = 0 ; i < width;i++){
    stroke((sin(time/speed*TWO_PI+pow(i,slope))+1.0)*127.0);
    line(i,0,i,height);
  }


}
