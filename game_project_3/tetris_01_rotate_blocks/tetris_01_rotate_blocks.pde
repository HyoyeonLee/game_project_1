/*
TETRIS from the scratch by HYOYEON LEE 2021.05.31

[stacking]
1) enum doesnt work in Processing, just use indices blk_idx and rot_idx
2) activated keys are the four arrows and a space bar.
3) need to have an array that keeps track of "occupied"/"vacant"
4) The coors of the edges of every block rotated by a specific angle are needed.
5) if edgeIdx == occupiedIdx, reverse the inc/dec and saveFrame as bg.jpg


[clear]
if all rows are occupied, remove that row 
and pushes the upper parts to be connected to the lower.

*/
char blk_names[] = {'L','O','I','T','Z','S'};
int blk_idx,rot_idx;
int x,y,isNew;
int x0,y0;
PImage img;
int dl=100;
int step = 20;
String get_fname(int blk_idx, int rot_idx)
{
  return "block"+blk_names[blk_idx]+str(rot_idx)+".jpg";
}

void setup()
{
  size(300,550);
  background(255);
  x0=width/2;y0=80;
  blk_idx=(int)random(0,5);
  rot_idx=(int)random(0,4);
  isNew=1;
  imageMode(CENTER);
}
void draw()
{
 
  background(255);
  if(isNew==1)
  {
    x=x0;y=y0;
    isNew=0;
  }
 
  img = loadImage(get_fname(blk_idx,rot_idx));
  image(img,x,y,dl,dl);
  y=y+step;
  delay(100);
}
void keyPressed()
{
  if(key==CODED)
  {
    switch(keyCode){
      case UP: 
        rot_idx=(rot_idx+1)%4;
        break;
      case DOWN: 
        rot_idx=(rot_idx-1+4)%4;
        break;
      case RIGHT: 
        x = (x + step)%width;
        break;
      case LEFT: 
        if(x==dl/2){}
        else 
        {
          x = x - step;
        }
        break;
      case 0x20:
        if(y==height-dl/2){}
        else
        {
          y=y+step*3;
        }
    }
  }
  //if(key=='q')  gameOver();
}
  
