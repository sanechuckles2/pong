

enum Position {
  top, bottom;
};


class Player {
  final float maxX = 700;
  float x = 0;
  float y = 0;
  float width = 100;
  float height = 15;
  int padlespeed = 8;
  int score = 0;
  private Position position;
  private char left;
  private char right;
  float paddleHitY = 0;

  Player(Position position, int w, int h) {
    this.position = position;
    this.x = w/2;
    switch(this.position) {
    case top:
      this.y = this.height;
      this.left = 'j';
      this.right = 'l';
      this.paddleHitY = this.y + this.height;
      break;
    case bottom:
      this.y = h - this.height * 2;
      this.left = 'a';
      this.right = 'd';
      this.paddleHitY = this.y;
      break;
    }
  }

  void draw() {
    rect(x, y, this.width, this.height);
  }

  float maxXpos(float by) {
    this.x += by;
    if (this.x < 0) {
      this.x = 0;
    }
    if (this.x > this.maxX) {
      this.x = this.maxX;
    }
    return this.x;
  }

  void move() {
    if (keysIn.contains(this.left)) {
      this.x -= padlespeed;
    }
    if (keysIn.contains(this.right)) {
      this.x += padlespeed;
    }
  }

  boolean hasCollided(Ball ball) {
    boolean isOnLine = ((ball.x) >= this.x && (ball.x) <= (this.x + this.width));
    if (isOnLine) {
      switch(this.position) {
      case top:
        return (ball.y - ball.radius) == this.paddleHitY;
      case bottom:
        return (ball.y + ball.radius) == this.paddleHitY;
      }
    }
    return false;
  }

  void run() {
    move();
    draw();
  }
}