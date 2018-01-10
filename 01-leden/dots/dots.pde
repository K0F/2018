


void setup(){
size(480,480);

}


void draw(){
  
  storke(255);
  for(int y = 0 ; y < width;y+=5){
  for(int x = 0 ; x < width;x+=5){
      point(x,y);
  }
  }

}
