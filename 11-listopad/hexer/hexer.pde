

void setup(){
  size(640,480,OPENGL);
  smooth();

}


void draw(){
  background(0);
  noFill();
  stroke(255,50);
  int c =0;
  int n = 100;
  for(int i =0;i<n;i++){
    strokeWeight(map(i,0,n,2,5));
    float amp = (sin(millis()/10000.0)+1.0);
    hexagon(width/2,height/2,map(i,0,n,5,200),7.0,sin((millis()+i*10.0*cos((i*10.0+millis())/10000.1))/10000.0)*3600.0);
    c++;
  }
}


void hexagon(float x,float y,float r,float N,float rho){
  float step = TWO_PI/N;
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
