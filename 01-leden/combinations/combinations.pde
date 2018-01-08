import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


void setup(){
  //size(1600,900,P2D);
  frameRate(120);
  //surface.setLocation(100, 100);
  //try { Thread.sleep(6000); } catch (InterruptedException e) { }
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",10001);
  fullScreen(OPENGL);
}

void send(){
  OscMessage myMessage = new OscMessage("/bang");
  myMessage.add(1);
  oscP5.send(myMessage, myRemoteLocation);


}

float x;
float R;
float cyc = (120/125.43)*1000.0;
color c[] = {color(255,0,0),color(0,255,0),color(0,0,255)};

void draw(){
  if(frameCount==1)
  send();

  background(0);
  cyc = (millis()/((120.0/120.0)*1000.0))*TWO_PI;
  for(int i = 1 ; i < 70 ; i++){

    R = (sin(cyc/(32.0*i))+1.0)*200.0;
    x = (sin(cyc/(8.0*i) )+1.0)*(width/2.0-(R/2.0))+(R/2.0);
    ellipseMode(CENTER);
    noStroke();
      fill(255,(sin(cyc/64/(i+0.0))+1.0)*12.7 );
    ellipse(x,height/2,R,R);
  }
}



class Thing{
  PVector pos;
}
