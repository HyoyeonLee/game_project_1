
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
int[][] bg_state = new int[31][20];
int count=10;
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
   type=0;//(int)random(0,blk_names.length); //randomly chosen block type
   rot=1;//(int)random(0,4); //randomly rotated state by {0,90,180,270}
   type=0;rot=1;
   isNew=1;
}
void update_bg_state(int type,int rot,int x,int y)
{
  int ic=y/20,jc=x/20;
  for(int i=ic-3;i<ic+3;i++)
  {
    for(int j=jc-3;j<jc+3;j++)
    {
      bg_state[i][j]+=blk_org[type][rot][i-(ic-3)][j-(jc-3)];
    }
  }
}
int isAllowed(int type,int rot,int x, int y)
{
  int ic=y/20,jc=x/20;
  println(" ");println(" ");print(count);println(" **********************");
  for(int i=ic-3;i<ic+3;i++)
  {
    int bi,bj;
    for(int j=jc-3;j<jc+3;j++)
    {
      bi=i-(ic-3);
      bj=j-(jc-3);
      int bg_el=bg_state[i][j];
      int blk_el=blk_org[type][rot][i-(ic-3)][j-(jc-3)];
    if(count<4)
      {
        print("(i,j|bi,bj)= ",i,j,bi,bj);
        print(",  (bg,blk)=",bg_el,blk_el);println(" ");
      }
        
    if(bg_el>=(2-blk_el)){return 0;}
    }
  }
  return 1;
}

void setup()
{
  size(400,620);
  background(255);
  saveFrame(bg_fname);
  imageMode(CENTER);
  //-------------------------------------------------BG load (well shape)
  img_bg = loadImage(initial_bg_fname);
  image(img_bg,width/2,height/2,width,height);
  saveFrame(bg_fname);
  for(int yIdx=0;yIdx<31;yIdx++)
  {
    for(int xIdx=0;xIdx<20;xIdx++)
    {
      bg_state[yIdx][xIdx] = bg_org[yIdx][xIdx];
      //print(bg_state[yIdx][xIdx],",");
    }
  }
  //------------------------------------------------ Choose the 1st block
  x0=width/2;y0=60; //top center
  //debug
  type=0;//(int)random(0,7); //random block type
  rot=1;//(int)random(0,4); //randomly rotated
  isNew=1; //1:(x,y)=(x0,y0), 0:(x,y)=on the fly
  delay(500);
  count=0;
}


void draw()
{ 
  //-----------------------------------------------1) Updated bg.png is loaded
  img_bg = loadImage(bg_fname);
  image(img_bg,width/2,height/2,width,height);
  //-----------------------------------------------2) introduce the new/existing block with updated (x,y)
  img_blk = loadImage(get_blk_fname(type,rot));
  if(isNew==1)
  {
    x=x0;
    y=y0;
    isNew=0;
  }    
  image(img_blk,x,y,dl,dl);
  //-----------------------------------------------3) Check for stacking condition
  int isAllowed_result = isAllowed(type,rot,x,y);
  if(isAllowed_result==0)
  {
     saveFrame(bg_fname);
     refresh();
     delay(1000);
     //count=1;
  }
  else 
  {
    //image(img_blk,x,y,dl,dl);
    y=y+step;
    update_bg_state(type,rot,x,y);
    delay(1000);
    //count=2;
  }
  count++;
}
//-------------------------------------------------[KEY ACTION]
void keyPressed()
{
  int temp_rot,temp_x,temp_y;
  if(key==CODED)
  {
    switch(keyCode)
    {
      case UP: 
        //rot=(rot+1)%4;    
        temp_rot = (rot+1)%4;
        if(isAllowed(type,temp_rot,x,y)==0)
        {
           saveFrame(bg_fname);
           refresh();
        }
        else 
        {
          rot=temp_rot;
          update_bg_state(type,rot,x,y);
          delay(100);
        }
        break;
      case DOWN:   
        temp_rot = (rot-1+4)%4;
        if(isAllowed(type,temp_rot,x,y)==0)
        {
           saveFrame(bg_fname);
           refresh();
        }
        else 
        {
          rot=temp_rot;
          update_bg_state(type,rot,x,y);
          delay(100);
        }
        break;
      case RIGHT: 
        temp_x = x+step;
        if(isAllowed(type,rot,temp_x,y)==0)
        {
           saveFrame(bg_fname);
           refresh();
        }
        else 
        {
          x=temp_x;
          update_bg_state(type,rot,x,y);
          delay(100);
        }
        break;
      case LEFT:
        temp_x = x-step;
        if(isAllowed(type,rot,temp_x,y)==0)
        {
           saveFrame(bg_fname);
           refresh();
        }
        else 
        {
          x=temp_x;
          update_bg_state(type,rot,x,y);
          delay(100);
        }
        break;
      case 0x20://space bar
        temp_y = y+5*step;
        if(isAllowed(type,rot,x,temp_y)==0)
        {
           saveFrame(bg_fname);
           refresh();
        }
        else 
        {
          y=temp_y;
          update_bg_state(type,rot,x,y);
          delay(100);
        }
        break;
    }
  }
}
  
