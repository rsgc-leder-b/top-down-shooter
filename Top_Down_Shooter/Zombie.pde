class Zombie {
  int seen;
  int looking;
  float x;
  float y;
  float xspeed;
  float yspeed;
  float xlook;
  float ylook;
  float spotx;
  float spoty;
  PVector movement;
  int health = 100;
  int attack = 0;

  void spawn() {
    health = 100;
    seen = 0;
    looking = 0;
    int chooser = int(random(100));
    int picker = int(random(100));
    if (chooser % 2 == 0) {
      x = random(30, width-30);
      if (picker % 2 == 0) {
        y = 30;
      } else {
        y = height - 30;
      }
    } else {
      y = random(30, height - 30);
      if (picker % 2 == 0) {
        x = 30;
      } else {
        x = width - 30;
      }
    }

    xspeed = 1;
    yspeed = 1;
    movement = new PVector(0, 0);
  }

  void move() {

    if (seen == -180) {
      seen = 0;  
      int choose = int(random(10));
      int pick = int(random(10));
      if (pick % 2 == 0) {
        xspeed = 1;
      } else {
        xspeed = -1;
      }
      if (choose % 2 == 0) {
        yspeed = 1;
      } else {
        yspeed = -1;
      }
    }


    seen -= 1;
    if (frameCount % 10 == 0) {


      if (dist(x, y, p.location.x, p.location.y) < 600) {
        seen = 30;
        xlook= (p.location.x - x) / 100;
        ylook= (p.location.y - y) / 100;
        spotx = x;
        spoty = y;
        for (int u = 0; u < 100; u++) {
          spotx = x + (xlook * u);
          spoty = y + (ylook * u);
          for (int i = 0; i < walls.length; i++) {
            if (spotx > walls[i].x - walls[i].wide/2 && spotx < walls[i].x + walls[i].wide/2 && spoty > walls[i].y - walls[i].high/2 && spoty < walls[i].y + walls[i].high/2) {
              seen = 0;
            }
          }
        }
      }
      if (seen > 0) {
        movement.x = xlook;
        movement.y = ylook;
        movement.normalize();
        movement.mult(2);
        xspeed = movement.x;
        yspeed = movement.y;
        seen -=1;
      }
    }
    for (int i = 0; i < walls.length; i++) {
      if (frameCount % 100 == 0 && x > walls[i].x - walls[i].wide/2 && x < walls[i].x + walls[i].wide/2 && y > walls[i].y - walls[i].high/2 && y < walls[i].y + walls[i].high/2) {
        spawn();
      }
      if (x > walls[i].x - walls[i].wide/2 && x < walls[i].x + walls[i].wide/2 && y+yspeed > walls[i].y - walls[i].high/2 && y+yspeed < walls[i].y + walls[i].high/2) {
        yspeed = yspeed * -1;
      }

      if (x+xspeed > walls[i].x - walls[i].wide/2 && x+xspeed < walls[i].x + walls[i].wide/2 && y > walls[i].y - walls[i].high/2 && y < walls[i].y + walls[i].high/2) {
        xspeed = xspeed * -1;
      }
    }
  }


  void walk() {
    x+=xspeed;
    y+=yspeed;
  }


  void display() {
    if (attack > 0) {
      attack -= 1;
    }
    pushMatrix();
    translate(x, y);
    rotate(atan2((y + yspeed)-y, (x + xspeed)-x ));
    strokeWeight(2);
    stroke(0);
    fill(30, 55, 42);
    rect(10 + attack / 3, 20, 30, 10, 2);
    rect(10 + attack / 3, -20, 30, 10, 2);
    rect(0, 0, 20, 50, 5);
    fill(0, 100, 0);
    ellipse(0, 0, 30, 30);
    ellipse(30+ attack / 3, -20, 15, 15);
    ellipse(30+ attack / 3, 20, 15, 15);
    popMatrix();
    fill(255, 0, 0, 100);
    noStroke();
    rect(x, y - 50, health/2, 10);
    fill(0, 0);
    stroke(0);
    strokeWeight(1);
    rect(x, y - 50, 50, 10);
  }
  //dank
  void attack() {
    for (int q = 0; q < p.i; q++) {
      if (w.weapon != 3) {
        if (dist(bullets[q].x, bullets[q].y, x, y) < 20) {      
          bullets[q].x = -100;
          if (w.weapon == 1) {
            health-=40;
          } else if (w.weapon == 2) {
            health -= 30;
          }
          if (health <= 0) {
            x = -100;
          }
        }
      } else {
        if (dist(bullets[0].x, bullets[0].y, x, y) < 40) {  
          if (w.canknife = true) {
            health -= 100;
            bullets[0].x = -100;
            w.canknife = false;
            if (health <= 0) {
              x = -100;
            }
          }
        }
      }
    }//so dank
    if (dist(p.location.x, p.location.y, x, y) < 30) {
      xspeed = 0;
      yspeed = 0;
      if (attack == 0) {
        p.health -= 30;
        attack = 40;
      }
    }
  }//how dank?
}
//as dank as possebru
