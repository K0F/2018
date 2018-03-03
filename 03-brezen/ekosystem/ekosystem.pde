
float harm[]={1,1.5,2,4,8,32,16,1.33333333,1.25};
float speed = (143.721/120.0/4.0);
float offset = 0;
float lsec = 0;
boolean sync = false;

void setup(){
  fullScreen(P2D);
  lsec = second();
  rectMode(CENTER);
}

void draw(){
 
  
  if(lsec!=second() && !sync){
  offset = millis();
  sync = true;
  }
  lsec = second();

  float pulsine = (cos(((millis()-offset)/1000.0*speed)*TWO_PI)+1.0)/2.0;
  background(0);
  fill(255,127);
  noStroke();
  for(int i = 0 ; i < 7;i++){
  float pulsine2 = (cos(((millis()-offset)/1000.0*speed/harm[i])*TWO_PI)+1.0)/2.0;
  rect(pulsine2*width,height/2,100,height);

  }

  

}
