int x,y,bearX,bearY;
int step=20;
int score=0;
PImage field,bear,bunny;
int button;
PFont font;
String str="Score: ";
color now,c = color(0,255,0);
void gameOver()
{
        textAlign(CENTER,CENTER);
        fill(0);
        text("GAME OVER",width/2,height/2);
        noLoop();
}
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
  bearX = (int)random(100,500);
  bearY = (int)random(100,500);
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
      break;
    case 1:
      y+=step;
      break;
    case 2:
      x+=step;
      break;
    case 3:
      x-=step;
      break;
  }
  now = get(x,y);
  if(green(now)==255 && red(now)<30 && blue(now)<30)
  {
    gameOver();
  }
}
void draw()
{
  //refreshing inside the field
  imageMode(CORNER);
  image(field,0,0,600,600);
  text(str+score,40,40);
  imageMode(CENTER);
  if(abs(x-bearX)<20 && abs(y-bearY)<20)
  {
    score+=10;
    bearX=(int)random(100,500);
    bearY=(int)random(100,500);
    step = 5*(score/50)+20;
  }
  //bear
  image(bear,bearX,bearY,100,100);
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
      case UP: 
        button=0;
        break;
      case DOWN: 
        button=1;
        break;
      case RIGHT: 
        button=2;
        break;
      case LEFT: 
        button=3;
        break;
    }
  }
  if(key=='q')
  {
    gameOver();
  }
}
