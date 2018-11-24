

void setup(){
  size(640,480,P2D);

}


void draw(){
  background(0);
  noFill();
  stroke(255,150);
  int c =0;
  int n = 36;
for(int i =0;i<n;i++){
  strokeWeight(map(i,0,n,2,5));
  float amp = (sin(millis()/10000.0)+1.0);
  hexagon(width/2,height/2,map(i,0,n,5,200),noise((millis()+i*100.0)/10000.0)*360);
  c++;
  }

}


void hexagon(float x,float y,float r,float rho){
  float step = TWO_PI/6.0;
  pushMatrix();
  translate(x,y);
  rotate(radians(rho));
  beginShape();
  for(float f = -PI;f<PI;f+=step){
    float X = cos(f)*r;
    float Y = sin(f)*r;
    vertex(X,Y);
  }
  endShape(CLOSE);
  popMatrix();
}
