class Bamboo {

  float x, y, t, h, grow, growSpeed, opacity;
  color col;
  float curT, curH;
  ArrayList<Branch> branches;
  float branchDirection;

  Bamboo(float _x) {
    this.x = _x;
    this.y = height;
    this.t = random(8, 15);
    this.h = random(height * 0.80, height * 0.95);
    this.grow = 0.0;
    this.growSpeed = 0.0;
    this.opacity = 255;

    this.col = color(155+random(30), 204+random(30), 135+random(30)); 

    //this.curT; //current thickness/thiness
    //this.curH; //current height

    //this.branches = [];
    this.branches = new ArrayList<Branch>();
    this.branchDirection = 1;

    // this.leaves = [];
  }



  void update() {
    this.growSpeed = map(mouseY, height, 0, 0.001, 0.020);
    this.grow = this.grow + this.growSpeed;
    if (this.grow > 1.0) {
      this.grow = 1.0;
    }
    this.curT = map(this.grow, 0.0, 1.0, this.t / 4, this.t);
    this.curH = this.y - this.h * this.grow;
  }

  void createBranch() {
    if (this.grow > 0.40 && this.grow < 0.95) {
      if (random(1.0) < 0.2) {
        this.branches.add(new Branch(this.x, this.curH, this.branchDirection));
        this.branchDirection = this.branchDirection * -1;
      }
    }
  }

  void display() {
    // draw branches
    for (int i = 0; i < this.branches.size(); i++) {
      //this.branches[i].run();
      this.branches.get(i).run();
    }


    // stalk
    stroke(this.col);
    strokeWeight(this.curT);
    line(this.x, this.y, this.x, this.curH);

    // break
    noFill();
    stroke(255);
    strokeWeight(1);
    for (int i = 0; i < this.h; i += this.h / 5) {
      float x = this.x;
      float y = this.y - i;
      float size = this.curT;
      //angleMode(RADIANS);
      arc(x, y, size * 2, size * 2, PI * 0.3, PI * 0.7);
    }
  }
}

class Branch {
  float startX, startY, endX, endY, t, grow;
  float d;

  Branch(float _x, float _y, float _d) {
    this.startX = _x;
    this.startY = _y;
    this.endX = _x + random(30, 60) * _d;
    this.endY = _y + random(-30, -60);
    this.t = 2;
    this.grow = 0.0;
    this.d = _d;
  }

  // this.leaves = [];

  void run() {
    //update
    this.grow = this.grow + 0.01;
    if (this.grow > 1.0) {
      this.grow = 1.0;
    }
    float curX = lerp(this.startX, this.endX, this.grow);
    float curY = lerp(this.startY, this.endY, this.grow);

    // draw
    //stroke(#27423A);
    stroke(#B0DB84);
    strokeWeight(this.t);
    line(this.startX, this.startY, curX, curY);
    // leaf
    if (this.grow == 1.0) {
      // var leaf = new Leaf(this.endX, this.endY);
      // this.leaves.push(leaf);

      // noStroke();
      this.drawLeaf();
    }

    // for (var i = 0; i < this.leaves.length; i++) {
    //   this.leaves[i].run();
    // }
  }

  void drawLeaf() {
    strokeWeight(1);
    stroke(#B0DB84);
    fill(155,204,135);
    pushMatrix();
    translate(this.endX, this.endY);
    
    // sin( FREQUENCY ) * AMPLITUDE + STARTING VALUE;
    // FREQUENCY can be angle or time
    
    float angle = radians(sin(frameCount*0.03) * 30);
    rotate(angle);
    quad(0, 0, 20 * this.d, 20, 25 * d, 30, 10 * d, 20);
    quad(0, 0, 20 * this.d, -5, 30 * d, -2, 20 * d, 5);
    quad(0, 0, -2 * d, 20, -5 * d, 30, -10 * d, 20);
    popMatrix();
  }
}



// function Leaf(x, y) {
//   this.x = x;
//   this.y = y;

// need a run function
// animate the leaf there
// first just draw it before animating



// }