int [] design = {
7,
32,32,32,32,
32,32,32,32,
32,32,32,32,
32,32,32,32,
32,32,32,32,
32,32,32,32,
32,32,32,32,
32,32,32,32,
32,32,32,32,
32,32,32,32,
32,32,32,32,
7};

Network A;
Network B;

float bias = 0.0;

float speed1 = 2.01;
float speed2 = 4.01;

void setup() {

  size(320, 320, P2D);
  A = new Network(design,speed1);
  B = new Network(design,speed2);
  
}

void draw() {

bias = 1.0;

  background(255);

  noStroke();

  float vals[] = new float[design[0]];
  float vals2[] = new float[design[0]];

  float x = 10;

  if(frameCount>1){

  for(int i = 0; i < vals.length;i++){
  Trail t = (Trail)A.trails.get(i);
  vals[i] = (Float)t.points.get(0);
  }
  }
  
  vals = B.getOutputs();
  A.feed(vals);
  A.step();
  A.draw(x, 10);
  x+=design.length*3+10;
  
 
  
  vals = A.getOutputs();
  B.feed(vals);
  B.step();
  B.draw(x, 10);
  x+=design.length*3+10;
  

/*  
  vals = C.getOutputs();
  C.feed(vals);
  C.step();
  C.draw(x, 10);
  x+=design.length*3+10;
  
  vals = D.getOutputs();
  D.feed(vals);
  D.step();
  D.draw(x, 10);
  x+=design.length*3+10;
  */
}

class Trail {
  ArrayList points;

  Trail() {
    points = new ArrayList();
  }

  void add(float _in) {
    points.add(_in);
    if (points.size()>design.length*3)
      points.remove(0);
  }

  void draw() {
    for (int i = 1; i < points.size(); i++) {
      float a =  map((Float)points.get(i-1), -2, 1, 90, 10); 
      float b =  map((Float)points.get(i), -2, 1, 90, 10); 
      line(i-1, a, i, b);
    }
  }
}

class Network {

  ArrayList trails;
  ArrayList layers;
  int scheme[];
  float speed = 1;

  Network(int [] _scheme,float _speed) {
    scheme = _scheme;
    speed= _speed;
    layers = new ArrayList();

    for (int i = 0; i < scheme.length; i++) {
      layers.add(new Layer(this, i, scheme[i]));
    }

    trails = new ArrayList();
    for (int i = 0; i < scheme[scheme.length-1]; i++)
      trails.add(new Trail());
  }

  void feed(float [] _vals) {
    Layer first = (Layer)layers.get(0);
    for (int i = 0; i < first.neurons.size(); i++) {
      Neuron n = (Neuron)first.neurons.get(i);
      n.val = _vals[i];
    }
  }

  void step() {
    for (int i = 0; i < layers.size(); i++) {
      
      Layer tmp = (Layer)layers.get(i);
      tmp.step();
    }
  }

  void draw(float x, float y) {
    noStroke();
    resetMatrix();
    pushMatrix();
    translate(x, y);
    for (int i = 0; i < layers.size(); i++) {
      Layer l = (Layer)layers.get(i);
      translate(3, 0);
      l.draw();
    }
    
    
    resetMatrix();
    
    translate(x, y+200);
    stroke(0, 25);

    float [] vals = getOutputs();

    for (int i = 0; i < vals.length; i++) {
      Trail t = (Trail)trails.get(i);
      t.add(vals[i]);
      t.draw();
    }
    popMatrix();
  }

  float [] getOutputs() {
    Layer last = (Layer)layers.get(layers.size()-1);
    float tmp[] = new float[last.neurons.size()];
    for (int i = 0; i < last.neurons.size(); i++) {
      Neuron n = (Neuron)last.neurons.get(i);
      tmp[i] = n.val;
    }
    return tmp;
  }
}

class Layer {
  ArrayList neurons; 
  int num;
  int id;
  Network net;

  Layer(Network _net, int _id, int _num) {
    net = _net;
    num = _num;
    id = _id;

    neurons = new ArrayList();
    for (int i = 0; i<num; i++) {
      Neuron tmp = new Neuron(this, i);
      
      neurons.add(tmp);
    }
  }

  void step() {
    for (int i = 0; i < neurons.size(); i++) {
      Neuron tmp = (Neuron)neurons.get(i);
      
      tmp.step();
    }
  }

  void draw() {
    for (int i = 0; i < neurons.size(); i++) {
      Neuron n = (Neuron)neurons.get(i);
      fill(map(n.val, -1, 1, 0, 255));
      rect(0, i*3, 2, 2);
    }
  }
}

class Neuron {
  float w[];
  float val;
  int id;
  boolean hidden;
  float speed = 1.01; 
  Layer parent;

  Neuron(Layer _parent, int _id) {
    parent = _parent;
    id = _id;
    speed = parent.net.speed;
    val = random(-1000, 1000)/1000.0;
    
    //speed= pow(id,0.99)+1.001;
    
    if (parent.id!=0) {
      hidden = true;
      w = new float[parent.net.scheme[parent.id-1]];
      for (int i = 0; i < w.length; i++) {
        w[i] = random(-10000,10000)/10000.0;
      }
    }
  }

  void step() {
    if (hidden) {
      Layer previousLayer = (Layer)parent.net.layers.get(parent.id-1);
      float sum = 0.0;
      float cnt = 0.0;
      for (int i = 0; i < previousLayer.neurons.size(); i++) {
        Neuron preN = (Neuron)previousLayer.neurons.get(i);
        sum += preN.val * w[i];  
       // w[i] += (((noise(w[i]+preN.val)-0.5)*w[i]))/10000.0;
        //w[i] += (random(-1, 1)-w[i])/(speed*speed);
        //w[i] += (sin((millis()*10.0)+(i*QUARTER_PI)+(parent.id*PI))-w[i])/100.0;
      }
      val += (sigmoid(sum)-val)/speed;
      /*
      if(id==0)
      val=bias;
      */
    }
  }

  float sigmoid(float _x) {
    return HALF_PI*atan(HALF_PI*_x);
  }
}
