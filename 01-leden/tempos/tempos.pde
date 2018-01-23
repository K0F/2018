
ArrayList entries;

String [] raw;
float avgTempo;

float ms;
void setup(){

  size(1600,900);
  raw = loadStrings("tempos_sort");
  entries = new ArrayList();
  for(int i = 0 ; i < raw.length;i++){
    entries.add(new Entry(raw[i],i));
  }

  avgTempo = getAvg();
  println("got " +  raw.length + " titles with average tempo " + avgTempo);

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
  ms=millis();

  for(int i = 0 ; i < entries.size();i+=1){
    Entry tmp = (Entry)entries.get(i);
    tmp.draw();
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
    line(x , height / 2 - 10 , x ,height / 2 - 11);
    
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
