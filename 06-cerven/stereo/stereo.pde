


void setup(){
  size(1280,720,P2D);

}




void draw(){

  background(5);

  stroke(255,120);
  sraf(width/2,height/2,100,100,120.0,millis()/3000.0);
  sraf(width/2,height/2,100,100,120.0,(-1.0)*millis()/3000.0);



}


void sraf(float x,float y, float w, float h, float rozpal,float angle){

  PVector a,b,c,d;
  float dia = sqrt(w*w+h*h);
  angle = angle - (HALF_PI/2.0);
  pushMatrix();
  translate(x,y);
  rotate(angle);
/*
line(a.x,a.y,b.x,b.y);
  line(b.x,b.y,c.x,c.y);
  line(c.x,c.y,d.x,d.y);
  line(d.x,d.y,a.x,a.y);
*/
  for(float f = 0.0 ; f < PI ; f+= (PI/rozpal) ){
  a = new PVector(cos(f+angle)*dia,sin(f+angle)*dia);
  b = new PVector(sin(f+HALF_PI+angle)*dia,cos(f+HALF_PI+angle)*dia);
  line(a.x,a.y,b.x,b.y);
  //c = new PVector(cos(f+PI)*dia,sin(angle+PI)*dia);
  //d = new PVector(cos(angle+PI+HALF_PI)*dia,sin(angle+PI+HALF_PI)*dia);
  
/*
    float abx = lerp(a.x,b.x,f);
    float aby = lerp(a.y,b.y,f);
    float bcx = lerp(a.x,b.x,f);
    float bcy = lerp(a.y,b.y,f);
    float cdx = lerp(a.x,b.x,f);
    float cdy = lerp(a.y,b.y,f);
    float dax = lerp(a.x,b.x,f);
    float day = lerp(a.y,b.y,f);
    line(abx,aby,cdx,cdy);
    line(bcx,bcy,abx,aby);
    line(cdx,cdy,dax,day);
    line(dax,day,abx,aby);
 */
 }
  popMatrix();

}
