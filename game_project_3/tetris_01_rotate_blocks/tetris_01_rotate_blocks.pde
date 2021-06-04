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
char blk_names[] = {'L','O','I','T','Z','S'};
int blk_idx,rot_idx;
int x,y,isNew,x0,y0;
PImage img_blk,img_bg;
int dl=100;          // 500x500 (unit=100) --resize to--> 100X100 (unit=20)
int edge_finding_unit=10;
int step = 20;       //unit size
String bg_fname = "bg.png"; //  
int edges[][][] = {//index[blk][rot][dB/dL/dR]
{{3,-2,2},{2,-3,3},{3,-2,2},{2,-3,3}},//L
{{2,-2,2},{2,-2,2},{2,-2,2},{2,-2,2}},//O
{{4,-1,1},{1,-4,4},{4,-1,1},{1,-4,4}},//I
{{3,-2,2},{2,-3,3},{3,-2,2},{2,-3,3}},//T
{{3,-2,2},{2,-3,3},{3,-2,2},{2,-3,3}},//Z
{{3,-2,2},{2,-3,3},{3,-2,2},{2,-3,3}} //S
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
   
   blk_idx=(int)random(0,5); //randomly chosen block type
   rot_idx=(int)random(0,4); //randomly rotated state
   isNew=1;
}


void setup()
{
  size(320,560);
  background(255);
  saveFrame(bg_fname);
  x0=width/2;y0=80; //top center
  blk_idx=(int)random(0,5); //randomly chosen block type
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
  dB=y+edge_finding_unit*edges[blk_idx][rot_idx][0];
  if(dB==height)
  {
    saveFrame(bg_fname);
    refresh();
  }
  else
  {
    y=y+step/2;
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
        break;
      case DOWN: 
        rot_idx=(rot_idx-1+4)%4;  //counter-clockwise (-90deg)
        break;
      case RIGHT: 
        dR=x+edge_finding_unit*edges[blk_idx][rot_idx][2];
        if(dR==width){}
        else x=x+step;
        break;
      case LEFT:
        dL=x+edge_finding_unit*edges[blk_idx][rot_idx][1];
        if(dL==0){}
        else x=x-step;
        break;
      case 0x20://space bar
        dB=y+edge_finding_unit*edges[blk_idx][rot_idx][0];
        if(dB==height){}
        else y=y+step/2;
        break;
    }
  }
}
  
