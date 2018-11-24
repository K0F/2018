
/**
Coded by Kof @ 
Fri Oct 19 05:14:54 CEST 2018

   ,dPYb,                  ,dPYb,
   IP'`Yb                  IP'`Yb
   I8  8I                  I8  8I
   I8  8bgg,               I8  8'
   I8 dP" "8    ,ggggg,    I8 dP
   I8d8bggP"   dP"  "Y8ggg I8dP
   I8P' "Yb,  i8'    ,8I   I8P
  ,d8    `Yb,,d8,   ,d8'  ,d8b,_
  88P      Y8P"Y8888P"    PI8"8888
                           I8 `8,
                           I8  `8,
                           I8   8I
                           I8   8I
                           I8, ,8'
                            "Y8P'
*/

ArrayList vectors;
float scal = 1500.0;
float amp = 150.0;
float blend = 0.55;
boolean render = false;

PImage start;

void setup() {
  noiseSeed(2018);
  size(1280,720);  
  start = loadImage("vvg.jpg");
  start.loadPixels();

  vectors = new ArrayList();

  for(int i = 0 ; i < width*height;i++)
    vectors.add(new PVector(0,0));

  loadPixels();
  for (int i = 0; i < pixels.length; i++)
    pixels[i] = color(0);

  update();
  updatePixels();

  //  image(start,0,0);
}

void update() {

  float harmonia[] = {2,3,5,7};
  for(int i = 0;i < harmonia.length;i++){
    float harm = (log(harmonia[i])/log(2));
    amp = pow(noise(frameCount/(120.0/12131.0)*i),2)*100.0*harm;
    scal = noise(frameCount/(120.0/12130.0)*i)*1000.0*harm;

    for (int y = 0; y < height; y++) {
      for (int x  = 0; x < width; x++) {

        PVector tmp = new PVector((noise(x/scal+10*harm, y/scal+10*harm, frameCount/scal*harm)-0.5)*amp, (noise(x/scal*harm, y/scal*harm,frameCount/scal*harm)-0.5)*amp);
        PVector that = (PVector)vectors.get(y*width+x);
        PVector radial = new PVector(cos(tmp.x*TWO_PI),sin(tmp.y*TWO_PI));
        that.x = (radial.x-that.x)/1000.0;
        that.y = (radial.y-that.y)/1000.0;
        that.normalize();
        //that = new PVector(radial.x,radial.y);
        that.mult(amp);
      }
    }
  }
}

void draw() {
  update();

  noStroke();
  color cc = start.pixels[frameCount%start.pixels.length];
  fill(cc,25);
  /*fill(
    (sin(frameCount/25.0/15.0*TWO_PI)+1.0)*127.0, 
    (sin(frameCount/25.0/5.0*TWO_PI)+1.0)*127.0, 
    (sin(frameCount/25.0/3.0*TWO_PI)+1.0)*127.0, 

    25);
   */
  ellipse(width/2, height/2, 300, 300);

  loadPixels();
  for (int y = 0; y < height; y++) {
    for (int x  = 0; x < width; x++) {

      blend = noise(x, y, frameCount/100.0)/4.0;
      PVector tmp = (PVector)vectors.get(y*width+x);
      float jitx = 0;//random(-1,1)/100.0;
      float jity = 0;//random(-1,1)/100.0;

      color a = color(pixels[y*width+x]);
      color b = color(pixels[((int)(y+tmp.y+jitx+height)%height)*width+( (int)(x+tmp.x+jity+width)%width)]);
      color c = lerpColor(a, b, blend);
      stroke(c);
      //point((x+tmp.x+width)%width,(y+tmp.y+height)%height);
      pixels[((int)(y+tmp.y+jitx+height)%height)*width+( (int)(x+tmp.x+jity+width)%width)] = c;
    }
  }
  updatePixels();
  //if(frameCount%25==0)
  //filter(BLUR,1.0);

  if (render)
    saveFrame("render######.png");
}
