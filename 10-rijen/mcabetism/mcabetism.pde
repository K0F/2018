ArrayList vectors;
float scal = 1500.0;
float amp = 1000.0;
float blend = 0.55;
boolean render = true;

PImage start;

void setup() {
  size(1024,768);  
  start = loadImage("test.png");

  loadPixels();
  for (int i = 0; i < pixels.length; i++)
    pixels[i] = color(0);

  update();
  updatePixels();

  //  image(start,0,0);
}

void update() {
  amp = pow(noise(frameCount/100.0),2)*100.0;
  scal = pow(noise(frameCount/250.0),2)*1000.0;


  vectors = new ArrayList();
  for (int y = 0; y < height; y++) {
    for (int x  = 0; x < width; x++) {
      PVector tmp = new PVector((noise(x/scal+10, y/scal+10, frameCount/scal)-0.5)*amp, (noise(x/scal, y/scal)-0.5)*amp);
      vectors.add(tmp);
    }
  }
}

void draw() {
  update();

  noStroke();
  fill(
    (sin(frameCount/25.0/15.0*TWO_PI)+1.0)*127.0, 
    (sin(frameCount/25.0/5.0*TWO_PI)+1.0)*127.0, 
    (sin(frameCount/25.0/3.0*TWO_PI)+1.0)*127.0, 

    25);
  ellipse(width/2, height/2, 300, 300);

  loadPixels();
  for (int y = 0; y < height; y++) {
    for (int x  = 0; x < width; x++) {

      blend = noise(x, y, frameCount/100.0);
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
