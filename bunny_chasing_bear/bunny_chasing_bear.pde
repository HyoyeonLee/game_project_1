int x,y,preyX,preyY;
int step=10;
int score=0;
PImage field,bear,bunny;
int button,pre;
PFont font;
String str="Score: ";
void setup()
{
  size(600,600);
  background(255);
  field = loadImage("game_project1_BG000.jpg");
  imageMode(CORNER);
  image(field,0,0,600,600);
  imageMode(CENTER);
  bear = loadImage("./bear.png");
  bunny = loadImage("./bunny.png");
  x=width/2;
  y=height/2;
  preyX = (int)random(100,500);
  preyY = (int)random(100,500);
  println(button);
  font = createFont("Consolas Bold",200);
  textFont(font);
  textSize(40);
  rectMode(CENTER);
  noStroke();
  
}
void position()
{
  switch(button)
  {
    case 0:
      y-=step;
      if(y<100)
      {
        textAlign(CENTER,CENTER);
        fill(0);
        text("GAME OVER",width/2,height/2);
        noLoop();
      }
     break;
    case 1:
      y+=step;
      if(y>500)
      {
        textAlign(CENTER,CENTER);fill(0);
        text("GAME OVER",width/2,height/2);
        noLoop();
      }
      break;
    case 2:
      x+=step;
      if(x>500)
      {
        textAlign(CENTER,CENTER);fill(0);
        text("GAME OVER",width/2,height/2);
        noLoop();
      }
      break;
    case 3:
      x-=step;
      if(x<100)
      {
        textAlign(CENTER,CENTER);
        fill(0);
        text("GAME OVER",width/2,height/2);
        noLoop();
      }
      break;
  }
}
void draw()
{
  //refreshing inside the field
  imageMode(CORNER);
  image(field,0,0,600,600);
  text(str+score,40,40);
  imageMode(CENTER);
  if(abs(x-preyX)<20 && abs(y-preyY)<20)
  {
    score+=10;
    preyX=(int)random(100,500);
    preyY=(int)random(100,500);
  }
  //prey
  image(bear,preyX,preyY,100,100);
  //chaser
  position();
  image(bunny,x,y,120,120);
  delay(200);
}

void keyPressed()
{
  if(key==CODED)
  {
    switch(keyCode){
      case UP: pre=button;button=0;break;
      case DOWN: pre=button;button=1;break;
      case RIGHT: pre=button;button=2;break;
      case LEFT: pre=button;button=3;break;
    }
  }
  if(key=='q')
  {
    fill(0);
    text("GAME OVER",width/2,height/2);
    noLoop();
  }
}
