float buffer[];
int len = 512;

void setup(){
  size(1280,720,P2D);
  buffer = new float[len];
  buffer = spiralPix(8,8);
}

void draw(){
  background(0);
}



float [] spiralPix(int X, int Y){

  float result[] = new float[len];  
  loadPixels();
  int x,y,dx,dy;
  x = y = dx =0;
  dy = -1;
  int t = max(X,Y);
  int maxI = t*t;
  for(int i = 0; i < maxI; i++){
    if ((-X/2 <= x) && (x <= X/2) && (-Y/2 <= y) && (y <= Y/2)){
      //result[i]=brightness(pixels[y*width+x]);
      println(x+":"+y);
    }
    if( (x == y) || ((x < 0) && (x == -y)) || ((x > 0) && (x == 1-y))){
      t = dx;
      dx = -dy;
      dy = t;
    }
    x += dx;
    y += dy;
  }




  return result;

}
