// neural net parameters
final int hidden_layers = 2;
final int hidden_nodes = 5;
final float mutationRate = 0.01;
final boolean humanPlaying = false;
final boolean replayBest = true;

int highscore = 0;

// game parameters
int ranks = 10;
boolean up, down, left, right;
boolean start;
int seconds;
int millisecs;

//create arrays
Enemy[] Army = new Enemy[ranks];

//create player
Hero p1;
//Population pop;

//collision variable
boolean collisionDetected;

void setup() {
  size(600, 650, P2D);
  //Create Enemies
  for (int i = 0; i < ranks; i++) {
    Army[i] = new Enemy();
  }
  // import hero character
  p1 = new Hero();
  
}
  
void restart() {
  seconds = 0;
  collisionDetected = false;
  start= true;
  setup();  
}
  /*
  void keyPressed() {
  if (keyCode == LEFT ||key == 'a') left = true;
  if (keyCode == RIGHT ||key == 'd') right = true;
  if (keyCode == UP ||key == 'w') up = true;
  if (keyCode == DOWN ||key == 's') down = true;
  if (key == 'r') restart();
  }

  void keyReleased() {
  if (keyCode == LEFT ||key == 'a') left =  false;
  if (keyCode == RIGHT ||key == 'd') right = false;
  if (keyCode == UP ||key == 'w') up = false;
  if (keyCode == DOWN ||key == 's') down = false;
  }
  */
  void draw() {
    background(100);
    //calculate amount of time player survived
    if(!collisionDetected){
      if (int(millis()/100)  % 10 != millisecs){
        millisecs++;
      }
      if (millisecs >= 10){
        millisecs -= 10;
        seconds++;
      }
    }
    //move enemies and check for collisions
    for (int i = 0; i < ranks; i ++) {
      Army[i].move();
      Army[i].check();
      Army[i].update();
    }

    p1.update();
    p1.look();
    p1.think();
    p1.move();


    //end game at detected collision
    if (collisionDetected == true) { 
      start=false;
      gameOver();
    }
  }
  
  void gameOver() { 
    //get rid of enemies
    for (int i = 0; i < ranks; i++) {
      Army[i].x = 5000;
    }
    p1.pos.x = -5000;

    textSize(30);
    text("You survived " + seconds + " seconds", 100, height/2);
  
    // mutate hero neural network and play again
    p1.mutate();
    restart();
  
  }
  
  
  
  
