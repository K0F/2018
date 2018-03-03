
ArrayList entries;
Searchbar search;

String [] raw;
float avgTempo;

float ms;

String query = "";
float phase;


void setup(){

  size(800,900);
  raw = loadStrings("tempos_sort");

  search = new Searchbar("");

  entries = new ArrayList();
  for(int i = 0 ; i < raw.length;i++){
    entries.add(new Entry(raw[i],i));
  }

  textFont(createFont("Semplice Regular",8,false),8);

  avgTempo = getAvg();
  println("got " +  raw.length + " titles with average tempo " + avgTempo);


}

void keyPressed(){
  if(key>='A' && key<='z')
    query += ""+(char)key;

  if(key>='0' && key<='9')
    query += ""+(char)key;


  if(keyCode==BACKSPACE && query.length()>=1)
    query = query.substring(0,query.length()-1);


  println(query);

  search.set(query);
    phase=millis();
}

// get average tempo of entries

float getAvg(){

  float sum = 0;
  for(int i = 0 ; i < raw.length;i++){
    Entry tmp = (Entry)entries.get(i);
    sum += tmp.tempo;
  }
  sum /= (raw.length+0.0);
  return sum;

}

void draw(){
  background(0);

  if(frameCount==1)
    phase=millis();


  ms=millis()-phase;



  fill(255);
  search.draw();

}

class Searchbar{
  String query;
  int x = width/2-100;
  int y = 20;
  ArrayList selection;

  Searchbar(String _query){
    query = _query+"";
    selection = new ArrayList();

  }

  void draw(){
    text(query,x,y);
    float yy = 30;
    float ty = 0;
    for(int i = 0 ; i < selection.size();i+=1){
      Entry tmp = (Entry)entries.get(i);
      fill(map(sin( ms/1000.0 * TWO_PI * tmp.speed ),-1,1,255,0));
      text(tmp.tempo + " " + tmp.name,10,yy+ty);
      ty+=9;
      tmp.draw();
    }
  }

  void set(String _input){
    selection = new ArrayList();
    query=_input;
    for(int i =0;i<entries.size();i++){
      Entry tmp = (Entry)entries.get(i);
      if(tmp.name.indexOf(query) != -1)
        selection.add(tmp);
    }
  }

}

class Entry{

  String name;
  float tempo;
  float speed;
  int id;

  Entry(String _raw,int _id){
    id = _id;
    String input[] = split(_raw,' ');
    tempo = parseFloat(input[0])*(24.0/25.0);
    name = input[1];
    speed = tempo/120.0;
  }

  void draw(){
    //try{
    float x = map(id,0,entries.size(),10,width-10);
    float y = map(sin( ms/1000.0 * TWO_PI * speed ),-1,1,0,255);
    stroke( 255 , 255-(pow(y/255.0,0.7)*255) );
    line( x , height / 2.0 - 1 + y , x , height / 2.0 + 1 + y );
    line( x , height / 2 - 10 , x ,height / 2 - 11 );

    //}catch(Exception e){
    //   ;
    //};
  }

  void draw_graph(){
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
