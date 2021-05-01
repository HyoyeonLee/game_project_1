
int x=100;
int y=100;
int diameter=100;
int green =0;
//float limit=(int)sqrt(pow(720,2)+pow(480,2));
int lim=720+480;
void setup()
{
  size(720,480);
  background(0,0,0);
}
void draw()
{
  background(0,0,0);
  fill(0,120+green,0);
  ellipse(x,y,(int)(diameter/2.0),(int)(diameter/2.0));
  //diameter=(int)sqrt(pow(mouseX,2)+pow(mouseY,2));
  diameter = (int)((mouseX+mouseY)*400.0/lim);
  green=(int)(diameter*255.0/lim);
  x=mouseX;//if(x>=(720+50)){x-=50;}
  y=mouseY;//if(x>=(480+50)){x-=50;}
}
