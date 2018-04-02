

/**

  Lightspeed operator helper
  copyleft ~ kof 18

*/

float SPEED = 6.0;

void setup(){
  size(128,128,P2D);
  colorMode(HSB,1024);
  frameRate(59.99);
}



void draw(){
  float time = ( sin( (millis() / 1000.0 * SPEED * TWO_PI) ) + 1.0 ) / 2.0 ;

  for(int y = 0 ; y < height ; y++){
    for(int x = 0 ; x < width ; x++){
      
      float h = map( (x-(width/2.0)+(time*width)) ,0,width,0,1024.0);
      float s = map(y,0,height,1024.0,0);
      float b = map(y,0,height,1024.0,0);
     
      color c = color(h,s,b);
      set(x,y,c);

    }
  }

  noStroke();

  pushStyle();
  colorMode(RGB,256);
  fill(255,(sin(millis()/1000.0*TWO_PI)/2.0+0.5)*255.0 );
  rect(0,height-3,3,3);
  popStyle();
}
