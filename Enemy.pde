class Enemy {
  //----data----//
  float x;
  float y;
  float xSpeed;
  float ySpeed;
  float diameter;
  float radius;
  color c = #FF7E64;

  //----constructor----//
  Enemy() {
    noStroke();
    x = 100;//random (100, width - 100);
    y = 100;//random (100, height -100);
    xSpeed = random(-7, 7);
    ySpeed = random(-7, 7);
    diameter = 40;
    radius = diameter/2;
  }


  //----functions----//

  //check for collision
   void check() {
    if (checkCollision(p1) == true) {
      collisionDetected = true;
    }
  }
  boolean checkCollision(Hero other) {
    if (dist(x, y, other.pos.x, other.pos.y) < radius + other.radius) {
      return true;
    } 
    else {
      return false;
    }
  }

  //Update position
  void move() {
    //check for bounce
    bounce();
    x = x + xSpeed; // change x location
    y = y + ySpeed; // change y location
  }

  //bounce
  void bounce() {
    if (x + radius > width || x - radius < 0) { // are we out of bounds?
      xSpeed = xSpeed *-1; //reverse direction of x
    }
    if (y + radius> height || y - radius < 0) {// are we out of bounds?
      ySpeed = ySpeed *-1; //reverse direction of y
    }
  }

  void update() {
    fill(c);
    ellipse(x, y, diameter, diameter); //draw the enemy
  }
}
