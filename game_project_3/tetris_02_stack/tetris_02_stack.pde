
/*
TETRIS from the scratch by HYOYEON LEE 2021.06.10

[stacking]
1) enum doesnt work in Processing, just use indices blk_idx and rot_idx
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
int blk_idx,rot_idx;
int x,y,isNew,x0,y0;
PImage img_blk,img_bg;
int dl=120;          // 600x600 (unit=100) --resize to--> 120X120 (unit=20)
int unit=20;
int step = 20;       //unit size
String bg_fname = "bg.png"; //
String initial_bg_fname = "../initial_bg/bg.png";
int[][] bg_state;
//*****************************************
//*   The filled state of the blocks are  * 
//*   automatically included              *
//*   (ex)L_org[rot][yIdx][xIdx]          *
//*****************************************
//-------------------------------------------------------------------------Function Pointers----
String get_blk_fname(int blk_idx, int rot_idx)
{
  String fname;
  String fpath = "../building_blocks_transparent/";
  fname = fpath+"block"+blk_names[blk_idx]+str(rot_idx)+".png";
  return fname;
}
void refresh()
{
   blk_idx=(int)random(0,blk_names.length); //randomly chosen block type
   rot_idx=(int)random(0,4); //randomly rotated state by {0,90,180,270}
   isNew=1;
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
  for(int yIdx=0;yIdx<height/20;yIdx++)
  {
    for(int xIdx=0;xIdx<width/20;xIdx++)
    {
      bg_state[yIdx][xIdx] = bg_org[yIdx][xIdx];
    }
  }
  //------------------------------------------------ Choose the 1st block
  x0=width/2;y0=60; //top center
  blk_idx=(int)random(0,7); //random block type
  rot_idx=(int)random(0,4); //randomly rotated
  isNew=1; //1:(x,y)=(x0,y0), 0:(x,y)=on the fly
  delay(500);
}


void draw()
{ 
  //-----------------------------------------------1) Updated BG is loaded
  img_bg = loadImage(bg_fname);
  image(img_bg,width/2,height/2,width,height);
  //-----------------------------------------------2) introduce the new/existing block with updated (x,y)
  if(isNew==1)
  {
    x=x0;
    y=y0;
    isNew=0;
  }    
  img_blk = loadImage(get_blk_fname(blk_idx,rot_idx));
  image(img_blk,x,y,dl,dl);
  //-----------------------------------------------3) Check for stacking condition
                                                      //block bottom == bg top : refresh (save bg)
                                                      //block bottom != bg top : go further down
  int stack_flag = is_hit_the_bottom(
  dB=y+edges[blk_idx][rot_idx][0];                  
  if(dB==height)                                    
  {
    saveFrame(bg_fname);
    refresh();
  }              
  else
  {
    y=y+step;
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
        rot_idx=(rot_idx+1)%4;    
        dR= x + edges[blk_idx][rot_idx][2];
        dL= x - edges[blk_idx][rot_idx][1];
        while(dR>width)
        {
          x = x-step;
          dR= x + edges[blk_idx][rot_idx][2];
        }
        while(dL<0)
        {
          x = x+step;
          dL= x - edges[blk_idx][rot_idx][1];
        }
        break;
      case DOWN: 
        rot_idx=(rot_idx-1+4)%4;  
        break;
      case RIGHT: 
        dR= x + edges[blk_idx][rot_idx][2];
        if(dR>=width){}
        else x=x+step;
        break;
      case LEFT:
        dL= x - edges[blk_idx][rot_idx][1];
        if(dL<=0){}
        else x=x-step;
        break;
      case 0x20://space bar
        dB= y + edges[blk_idx][rot_idx][0];
        if(dB==height){}
        else y=y+5*step;
        break;
    }
  }
}
  
