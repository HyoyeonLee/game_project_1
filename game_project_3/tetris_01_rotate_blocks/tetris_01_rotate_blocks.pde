/*
TETRIS from the scratch by HYOYEON LEE 2021.05.31

[stacking]
1) enum doesnt work in Processing, just use indices blk_idx and rot_idx
2) activated keys are the four arrows and a space bar.

3) need to have an array that keeps track of "occupied"/"vacant"
4) The coors of the edges of every block rotated by a specific angle are needed.
5) if edgeIdx == occupiedIdx, reverse the inc/dec and saveFrame as bg.png


[clear]
if all rows are occupied, remove that row.
and pushes the upper parts to be connected to the lower.
*/
char blk_names[] = {'I','J','L','O','S','T','Z'};
int blk_idx,rot_idx;
int x,y,isNew,x0,y0;
PImage img_blk,img_bg;
int dl=120;          // 500x500 (unit=100) --resize to--> 100X100 (unit=20)
int unit=20;
int step = 20;       //unit size
String bg_fname = "bg.png"; //  
//iB,jL,jR
int edges[][][] = {
{{40,20,0},{20,40,40},{40,0,20},{0,40,40}},
{{20,20,20},{20,20,40},{40,20,20},{20,40,20}},
{{20,40,20},{20,20,20},{20,20,40},{40,20,20}},
{{20,20,20},{20,20,20},{20,20,20},{20,20,20}},
{{20,40,20},{40,20,20},{20,20,40},{20,20,20}},
{{20,40,20},{20,20,20},{20,20,40},{40,20,20}},
{{20,40,20},{40,20,20},{20,20,40},{20,20,20}}
};


int dB,dL,dR;
String get_blk_fname(int blk_idx, int rot_idx)
{
  String fname;
  String fpath = "../building_blocks_transparent/";
  fname = fpath+"block"+blk_names[blk_idx]+str(rot_idx)+".png";
  return fname;
}
void refresh()
{
   
   blk_idx=(int)random(0,7); //randomly chosen block type
   rot_idx=(int)random(0,4); //randomly rotated state
   isNew=1;
}


void setup()
{
  println(width);
  size(360,600);
  background(255);
  saveFrame(bg_fname);
  x0=width/2;y0=60; //top center
  blk_idx=(int)random(0,7); //randomly chosen block type
  rot_idx=(int)random(0,4); //randomly rotated state
  isNew=1;                  //1:(x,y)=(x0,y0), 0:(x,y)=on the fly
  imageMode(CENTER);
}
void draw()
{ 
  img_bg = loadImage(bg_fname);
  image(img_bg,width/2,height/2,width,height);
  //background(255);
  if(isNew==1)
  {
    x=x0;
    y=y0;
    isNew=0;
  }    
  img_blk = loadImage(get_blk_fname(blk_idx,rot_idx));
  image(img_blk,x,y,dl,dl);
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
void keyPressed()
{
  if(key==CODED)
  {
    switch(keyCode)
    {
      case UP: 
        rot_idx=(rot_idx+1)%4;    //clockwise (+90deg)
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
        rot_idx=(rot_idx-1+4)%4;  //counter-clockwise (-90deg)
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
        else y=y+step;
        break;
    }
  }
}
  
