


void setup(){
  size(1600,900,P2D);

}



void draw(){
  background(
  (sin(millis()/30.123)+1.0)*127,
  (sin(millis()/30.234)+1.0)*127,
  (sin(millis()/30.345)+1.0)*127
  );
}
