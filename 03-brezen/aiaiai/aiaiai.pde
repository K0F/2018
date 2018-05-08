ArrayList neurons;


void setup(){
  size(320,240);
  int row = 0;
  neurons = new ArrayList();
  float x = 0;
  float y = 0;
  for(int i = 0;i<(28*28+16+16+10);i++){
    neurons.add(new Neuron(i,row,x,y));
    y++;
    if(i==28*28-1){
      row++;
      x+=32;
      y=0;
    }
    if(i==28*28-15){
      row++;
      x+=32;
      y=0;}
    if(i==28*28-31){
      row++;
      x+=32;
      y=0;
    }
  }
}

void draw(){
  background(0);
  for(int i = 0 ; i < neurons.size();i++){
    Neuron n = (Neuron)neurons.get(i);
    n.draw();
  }

}

class Neuron{
  int id;
  int row;
  float sum;
  float x;
  float y;
  ArrayList weights;
  ArrayList inputs;

  Neuron(int _id,int _row,float _x,float _y){
    x = _x;
    y = _y;
    id = _id;
    row = _row;
    weights = new ArrayList();
    inputs = new ArrayList();
    sum = 0.5;
  }

  void sum(){
    for(int i = 0 ; i < inputs.size();i++){
      Neuron tmp = (Neuron)neurons.get(i);
    }

  }

  void draw(){
    stroke(sum*255);
    point(x,y);

  }


}
