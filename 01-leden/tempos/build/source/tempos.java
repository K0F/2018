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

public class tempos extends PApplet {


ArrayList entries;
String [] raw;
float avgTempo;

public void setup(){
  
  raw = loadStrings("tempos_sort");
  entries = new ArrayList();
  for(int i = 0 ; i < raw.length;i++){
    entries.add(new Entry(raw[i],i));
  }
  avgTempo = getAvg()*(24.0f/25.0f);
  println(avgTempo);
}


// get average tempo of entries

public float getAvg(){

  float sum = 0;
  for(int i = 0 ; i < raw.length;i++){
    Entry tmp = (Entry)entries.get(i);
    sum += tmp.tempo;
  }
  sum /= (raw.length+0.0f);
  return sum;

}

public void draw(){
  background(0);


  for(int i = 0 ; i < entries.size();i++){
    Entry tmp = (Entry)entries.get(i);
    tmp.draw();
  }

}


class Entry{
  String name;
  float tempo;
  int id;

  Entry(String _raw,int _id){
    id = _id;
    String input[] = split(_raw,' ');
    tempo = parseFloat(input[0])*(24.0f/25.0f);
    name = input[1];
  }

  public void draw(){
    try{
      stroke(255);
      float x = map(id,0,entries.size(),0,width);
      float y = map(abs(avgTempo-tempo),0,60,10,height-10);
      line(x,y,x,height-10);
    }catch(Exception e){
      ;
    }
  }

}
  public void settings() {  size(720,576); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "tempos" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
