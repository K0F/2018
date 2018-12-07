import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

boolean test = false;

int x=0;
int div = 2;
float y;
int sel[];
ArrayList track;
boolean b= false;
float jump = -0.1;
boolean send = false;
float ssnd=0;
float in[];
float last[];
float bpm = 120.0;
int lock = 0;

void keyPressed(){

  if(key=='a'){
    lock-=1;
    lock=constrain(lock,0,in.length-1);
  }

  if(key=='d'){
    lock+=1;
    lock=constrain(lock,0,in.length-1);
  }



  if(key=='w'){
    div-=1;
    div=constrain(div,1,100);
    println("div: "+div);
  }
  if(key=='s'){
    div+=1;
    div=constrain(div,1,100);
    println("div: "+div);
  }
  if(key==' '){
    send=!send;
  }


}

void setup() {
  size(320, 240, P2D);
  frameRate(48);
  textFont(createFont("Monaco",8,false));
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);
  in = new float[10];
  sel=new int[10];
  last = new float[10];
  for(int i = 0 ; i < in.length;i++){
    last[i] = 0.0;
    in[i] = 0;
    sel[i] = 0;
  };

  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
}
void draw() {
  background(0);

  if(keyPressed){

    if(keyCode==LEFT){

      String[] ctl = new String[1];
      ctl[0] = ("seek "+(-1.0)+" relative");
      saveStrings("/tmp/ctl", ctl);
      ssnd = 255.0;
    }
    if(keyCode==RIGHT){

      String[] ctl = new String[1];
      ctl[0] = ("seek "+(1.0)+" relative");
      saveStrings("/tmp/ctl", ctl);
      ssnd = 255.0;
    }


    if(keyCode==UP){

      String[] ctl = new String[1];
      ctl[0] = ("seek "+(-15.0)+" relative");
      saveStrings("/tmp/ctl", ctl);
      ssnd = 255.0; 
    }
    if(keyCode==DOWN){

      String[] ctl = new String[1];
      ctl[0] = ("seek "+(15.0)+" relative");
      saveStrings("/tmp/ctl", ctl);
      ssnd = 255.0;
    }
    if(key>='0'&&key<='9'){
      println((int)key);

      String[] ctl = new String[1];
      ctl[0] = ("seek "+(1876.0/10.0*(((int)key-49)+0.0))+" absolute");
      saveStrings("/tmp/ctl", ctl);
      ssnd = 255.0;
    }

  }

  noStroke();
  float w = (width/(in.length+0.0));
  for(int i = 0 ; i < in.length;i++){
    fill(in[i]);
    rect(i*w,0,w,height);

    if(i==lock){
      fill(#ffcc00,127);
      rect(i*w,0,w,height);
      rect(i*w,map(div,1,16,0,height),w,height/16);
      fill(#ffffff);
      text(lock+":"+div,i*w+8,map(div,1,16,0,height)+12);
    }

    if(in[i]>0)
      in[i]-=5.1;
  }

  if(send){
    fill(#ff0000);
    rect(width-10,10,5,5);
  }

  fill(#ffcc11,ssnd);
  rect(width-15,10,5,5);
  fill(#00ff11,(sin((millis()/1000.0*bpm/120.0)*TWO_PI)+1.0)*127.0 );
  rect(width-20,10,5,5);

  if(ssnd>0)
    ssnd=-(2/48.0);

  if(test){
    if(frameCount%div==0){

      //x = 1;

      /*
         x++;
         if(x >= in.length){
         x=0;
         }
       */

      //ctl[0] = ("seek "+x+" absolute");
      if(send){

        String[] ctl = new String[1];
        ctl[0] = ("seek "+(-(millis()/1000.0-last[x]))+" relative");
        saveStrings("/tmp/ctl", ctl);
        println(x+" "+(-(millis()/1000.0-last[x])));
        last[x] = (millis()/1000.0);
      }

      in[x] = 255.0;
    }
  }

  fill(#ffcc00);
  text("bpm: "+bpm,10,12);

}


void oscEvent(OscMessage theOscMessage) {

  if(theOscMessage.checkTypetag("i")){
    x = theOscMessage.get(0).intValue()-1;
    // y = theOscMessage.get(1).floatValue();

    in[x] = 255.0;

    if(x==lock && send){
      sel[x]++;
      if(sel[x]%div==0){
        /*
           fill(#00ff00);
           rect(width-15,10,5,5);
           String[] ctl = new String[1];
           ctl[0] = ("seek "+(jump)+" relative");
           saveStrings("/tmp/ctl", ctl);
         */
        String[] ctl = new String[1];
        float tc = (millis()/1000.0-last[x]);
        ctl[0] = ("seek "+(-(tc))+" relative");
        saveStrings("/tmp/ctl", ctl);
        println(x+" "+(-(tc))+" bpm: "+(tc));
        bpm += ((60.0/(tc))-bpm)/4.0;
        last[x] = (tc);
        ssnd=255.0;

        println(x);
      }
    }
  }
}

