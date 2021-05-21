int x,y,bearX,bearY;
int step=15;
int score=0;
PImage field,bear,bunny;
int button;
PFont font;
String str="Score: ";
color now,c = color(0,255,0);
int isWall(int x,int y)
{
  int tempx,tempy;
  int dx[]= {-10,  0,0,10};
  int dy[]= {  0,-10,10,0};
  for(int i=0;i<4;i++)
  {
    tempx = x+dx[i];
    tempy = y+dy[i];
    now = get(tempx,tempy);
    if(green(now)==255 && red(now)<30 && blue(now)<30) return 1;
  }
  return 0;
}
void gameOver()
{
        textAlign(CENTER,CENTER);
        fill(0);
        text("GAME OVER",width/2,height/2);
        noLoop();
}
void getBearPosition()
{
  while(true)
  {
    bearX = (int)random(100,500);
    bearY = (int)random(100,500);
    if(isWall(bearX,bearY)==1)continue;
    else if(isWall(bearX,bearY)==0)break;
  }
}
  
void setup()
{
  size(600,600);
  background(255);
  field = loadImage("game_project1_BG002.jpg");
  imageMode(CORNER);
  image(field,0,0,600,600);
  imageMode(CENTER);
  bear = loadImage("./bear.png");
  bunny = loadImage("./bunny.png");
  x=100;
  y=300;
  getBearPosition();
  //println(button);
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
  if(isWall(x,y)==1)gameOver();
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
    step += 5;
  }
  //bear
  image(bear,bearX,bearY,80,80);
  //chaser
  position();
  image(bunny,x,y,100,100);
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
