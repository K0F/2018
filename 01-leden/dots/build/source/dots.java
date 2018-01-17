import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class dots extends PApplet {



float bpm = 115.0f/120.0f/16.0f;
float R = 10.0f;

public void setup(){
  
  println(dist(0,0,width,height)/(float)width);
}


public void draw(){

  background(0);
  float tempo = (millis()/1000.0f) * TWO_PI * bpm;
  stroke(255,66);
  for(int y = 0 ; y < width;y+=10){
    for(int x = 0 ; x < width;x+=10){
      float d = pow(dist(width/2,height/2,x,y)/(width/2.0f/1.4142135f),sin(tempo/32.0f)+1.0001f);
      float xx=(cos(tempo/d)*R)+x;
      float yy=(sin(tempo/d)*R)+y;
      pushMatrix();
      translate(xx,yy);
      rotate(tempo/d);
      line(0,sin(tempo/d)*(-R),0,sin(tempo/d)*R);
      popMatrix();
    }
  }

}
  public void settings() {  fullScreen(OPENGL); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "dots" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
