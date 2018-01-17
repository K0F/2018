
ArrayList entries;
String [] raw;
float avgTempo;

void setup(){
  size(720,576);
  raw = loadStrings("tempos_sort");
  entries = new ArrayList();
  for(int i = 0 ; i < raw.length;i++){
    entries.add(new Entry(raw[i],i));
  }
  avgTempo = getAvg()*(24.0/25.0);
  println(avgTempo);
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
    tempo = parseFloat(input[0])*(24.0/25.0);
    name = input[1];
  }

  void draw(){
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
