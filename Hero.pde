class Hero {
  // object data
  PVector pos;
  float size;
  float speed;
  float radius;
  int i = 0;
  
  boolean dead = false;
  boolean replay = true;
  
  // neural net data
  NeuralNet brain;
  float lifetime;
  float fitness;
  float[] vision;
  float[] decision;
  
  //constructor
  Hero() {
    lifetime = 1000;
    brain = new NeuralNet(8,hidden_nodes,5,hidden_layers);
    fitness = 0;
    //x = width/2;
    //y = height;
    pos = new PVector(width/2,height/2);
    size = 30;
    speed = 8;
    radius = size/2;
  }
  
  //functions
  void move() {
    if (left == true && pos.x > 25) {
      pos.x-= speed;
    }
    if (right == true && pos.x < width-25) {
      pos.x+= speed;
    }
    if (up == true && pos.y > 25) {
      pos.y-= speed;
    }
    if (down == true && pos.y < height-25) {
      pos.y+=speed;
    }
  }

  //update hero position on map
  void update() {
    fill(0,255,0);
    ellipse(pos.x, pos.y, size, size);
  }
  
  // hero vision array
  void look() {
    vision = new float[8];
    vision[0] = lookInDirection(new PVector(10,0));
    vision[1] = lookInDirection(new PVector(10,10));
    vision[2] = lookInDirection(new PVector(0,10));
    vision[3] = lookInDirection(new PVector(-10,10));
    vision[4] = lookInDirection(new PVector(-10,0));
    vision[5] = lookInDirection(new PVector(-10,-10));
    vision[6] = lookInDirection(new PVector(0,-10));
    vision[7] = lookInDirection(new PVector(10,-10));
  }
  
  // hero vision vectors
  float lookInDirection(PVector direction) {
     float look = 0;
     PVector vis = new PVector(pos.x, pos.y);
     float distance = 0;
     while(!collisionDetected) {
        if (vis.x < 0 || vis.x > width || vis.y < 0 || vis.y > height) {
          return 0; 
        }
        vis.add(direction);
        distance+=1;
        //Used to see vision
        fill(0);
        noStroke();
        ellipse(vis.x,vis.y,3,3);
     }
     look = 1/distance;
     return look;
  }
  
  //--Hero Thinking Functions--//
  void think() {
      decision = brain.output(vision);
      int maxIndex = 0;
      float max = 0;
      println(decision);
      for(int i=0; i< decision.length; i++) {
         if(decision[i] > max) {
            max = decision[i];
            maxIndex = i;
         }
      }
      
      switch(maxIndex) {
        // staying still
        case 0:
          left = false;
          right = false;
          up = false;
          down = false;
          move();
          break;
        // moving right 
        case 1:
          right = true;
          move();
          break;
       // moving up 
        case 2:
          up = true;
          move();
          break;
        // moving down 
        case 3:
          down = true;
          move();
          break;
        // moving left 
        case 4:
          left = true;
          move();
          break;
         
      }
  }
  
  // fitness is seconds hero remains alive
  float calculateFitness() {
     fitness = seconds;
     return fitness;
  }
  
  void mutate() {
     brain.mutate(mutationRate); 
  }
  
  
  Hero clone() {
     Hero clone = new Hero();
     clone.brain = brain.clone();
     return clone;
  }
  
  
  Hero cloneReplay() {
     Hero clone = new Hero();
     clone.brain = brain.clone();
     return clone;
  }
  
  
  Hero breed(Hero parent) {
     Hero child = new Hero();
     child.brain = brain.crossover(parent.brain);
     return child;
  }
  
}
