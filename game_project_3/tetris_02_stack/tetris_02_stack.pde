
/*
TETRIS from the scratch by HYOYEON LEE 2021.06.10

[stacking]
1) enum doesnt work in Processing, just use indices type and rot
2) activated keys are the four arrows and a space bar.
[done in tetris.01.ped]
--------------------------------------


3) need to have an array that keeps track of "occupied"/"vacant"
  --> state_bg[rows/unit][cols/unit] : occupied=1, vacant=0
  
4) The coors of the edges of every block rotated by a specific angle are needed.
  --> no need! each block with each rotation state has an array of the filled state (ex)state_L1,...
  
5) if edgeIdx == occupiedIdx, reverse the inc/dec and saveFrame as bg.png
 -->(L,R) key : state_blkn[y+][j]

[clear]
if all rows are occupied, remove that row.
and pushes the upper parts to be connected to the lower.
*/


char blk_names[] = {'I','J','L','O','S','T','Z'};
int type,rot;
int x,y,isNew,x0,y0;
PImage img_blk,img_bg;
int dl=120;          // 600x600 (unit=100) --resize to--> 120X120 (unit=20)
int unit=20;
int step = 20;       //unit size
String bg_fname = "bg.png"; //
String initial_bg_fname = "../initial_bg/bg.png";
int[][] bg_state = new int[37][30];
int[][] tempM = new int[37][30];
int count=10;
int ic,jc;
int bi,bj;
int bg_el, blk_el;
int rows,cols;
int isAllowed_result;
int sum;
String str;
int temp_rot,temp_x,temp_y;
//*****************************************
//*   The filled state of the blocks are  * 
//*   automatically included              *
//*   (ex)L_org[type][rot][yIdx][xIdx]          *
//*****************************************
//-------------------------------------------------------------------------Function Pointers----
String get_blk_fname(int type, int rot)
{
  String fname;
  String fpath = "../building_blocks_transparent/";
  fname = fpath+"block"+blk_names[type]+str(rot)+".png";
  return fname;
}
void refresh()
{
   //debug
   type = (int)random(0,blk_names.length); //randomly chosen block type
   rot  = (int)random(0,4); //randomly rotated state by {0,90,180,270}
   isNew=1;
}
void update_bg_state(int type,int rot,int x,int y)
{
  ic=y/20;jc=x/20;
  for(int i=ic-3;i<ic+3;i++)
  {
    for(int j=jc-3;j<jc+3;j++)
    {
      bi=i-(ic-3);
      bj=j-(jc-3);
      bg_el=bg_state[i][j];
      blk_el=blk_org[type][rot][bi][bj];
      sum =bg_el+blk_el; 
      tempM[i][j] = sum;
      bg_state[i][j] = sum;
    }
  }
}
void clear(int[][] mat)
{
  for(int i=0;i<37;i++)
  for(int j=0;j<30;j++)
  tempM[i][j]=0;
}
int isAllowed(int type,int rot,int x, int y)
{
  ic=y/20;jc=x/20;
  for(int i=ic-3;i<ic+3;i++)
  {
    for(int j=jc-3;j<jc+3;j++)
    {
      bi=i-(ic-3);
      bj=j-(jc-3);
      bg_el=bg_state[i][j];
      blk_el=blk_org[type][rot][bi][bj];
      sum =bg_el+blk_el; 
      tempM[i][j] = sum;
      if(tempM[i][j]==2){return 0;}
    }
  } 
  return 1;
}

void setup()
{
  size(600,740);
  rows = height/20;
  cols = width/20;
  background(255);
  saveFrame(bg_fname);
  imageMode(CENTER);
  //-------------------------------------------------BG load (well shape)
  img_bg = loadImage(initial_bg_fname);
  image(img_bg,width/2,height/2,width,height);
  saveFrame(bg_fname);
  for(int yIdx=0;yIdx<37;yIdx++)
    for(int xIdx=0;xIdx<30;xIdx++)
      bg_state[yIdx][xIdx] = bg_org[yIdx][xIdx];
  //------------------------------------------------ Choose the 1st block
  x0=width/2;y0=60; //top center
  //debug
  type = (int)random(0,7); //random block type
  rot  = (int)random(0,4); //randomly rotated
  isNew = 1; //1:(x,y)=(x0,y0), 0:(x,y)=on the fly
  delay(250);
}


void draw()
{ 
  if(isNew==1)
  {
    x=x0;
    y=y0;
    isNew=0;
  }
  temp_y = y+step;
  isAllowed_result = isAllowed(type,rot,x,temp_y);
  delay(150);
  if(isAllowed_result==0)
  {
     update_bg_state(type,rot,x,y);
     saveFrame(bg_fname);
     refresh();
     delay(100);
  }
  else 
  {
    y=temp_y;
    img_bg = loadImage(bg_fname);
    image(img_bg,width/2,height/2,width,height);
    img_blk = loadImage(get_blk_fname(type,rot));
    image(img_blk,x,y,dl,dl); 
    delay(100);
  }
}
//-------------------------------------------------[KEY ACTION]
void keyPressed()
{
  if(key==CODED)
  {
    switch(keyCode)
    {
      case UP: 
        temp_rot = (rot+1)%4;
        if(isAllowed(type,temp_rot,x,y)==0){}
        else {rot=temp_rot;}
        break;
      case DOWN:   
        temp_rot = (rot-1+4)%4;
        if(isAllowed(type,temp_rot,x,y)==0){}
        else {rot=temp_rot;}
        break;
      case RIGHT: 
        temp_x = x+step;
        if(isAllowed(type,rot,temp_x,y)==0){}
        else {x=temp_x;}
        break;
      case LEFT:
        temp_x = x-step;
        if(isAllowed(type,rot,temp_x,y)==0){}
        else {x=temp_x;}
        break;
      case 0x20://space bar
        temp_y = y+step;
        while(isAllowed(type,rot,x,temp_y)!=0)
        {
          y=temp_y;
          temp_y = y+step;
          delay(300);
        }
        break;
    }
  }
}
  
