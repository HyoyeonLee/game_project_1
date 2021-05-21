int x=0, y=0;
int count=0;
void setup()
{
  size(600,600);
  background(255);
  noStroke();
}
void draw()
{
  fill(0,255,0);
  //outer
  x=0;y=0;             rect(x,y,  width,    50);
  x=0;y=0;             rect(x,y,     50,height);
  x=width-50;y=0;      rect(x,y,     50,height);
  x=0;y=height-50;     rect(x,y,  width,    50);
  //additional block
  x=165;y=50;          rect(x,y,     30,   100);
  x=290;y=50;          rect(x,y,     30,   300);
  x=425;y=50;          rect(x,y,     30,   100);
  
  x=165;y=250;         rect(x,y,     30,   300);
  x=290;y=440;          rect(x,y,    30,   120);
  x=425;y=250;          rect(x,y,    30,   300);
  
  
}
void keyPressed()
{
  if(key=='s')
  {
    saveFrame("game_project1_BG"+nf(count,3)+".jpg");
    count++;
  }
}
