PImage img;
int cols=6,rows=6;
int[][] state = new int[cols][rows];
char blk_names[] = {'I','J','L','O','S','T','Z'};
String fpath = "../building_blocks_transparent/";
color w=color(255,255,255);
color fig;
int unit = 20; //panelL : 600-->120 ,  unit length : 100-->20
int iB,jL,jR;
int iB0=0, jL0=6, jR0=0;
String str;
int bg_width  = 300;
int bg_height = 600;

void setup()
{  
  size(120,120);
  background(255);
  imageMode(CENTER);
  iB=iB0;
  jL=jL0;
  jR=jR0;
  for(int yIdx=0;yIdx<rows;yIdx++){  
    for (int xIdx=0;xIdx<cols;xIdx++){
        state[yIdx][xIdx]=0;
      }
  }
 for(int type=0;type<blk_names.length;type++)
  {
    for(int rot=0;rot<4;rot++)
    {
      str = blk_names[type]+str(rot)+"={";
      println(str);
      background(255);
      String fname=fpath+"block"+blk_names[type]+str(rot)+".png";
      img = loadImage(fname);
      image(img,width/2,height/2,width,height);
      for (int yIdx=0;yIdx<rows;yIdx++)
      {
        print(" {");
        for(int xIdx=0;xIdx<cols;xIdx++)
        {
          fig = get(unit/2+xIdx*unit,unit/2+yIdx*unit);
          if (red(fig)>100 && green(fig)>100 && blue(fig)>100){state[yIdx][xIdx]=0;}//means white
          else {state[yIdx][xIdx]=1;}
          print(state[yIdx][xIdx]);
          if(xIdx!=cols-1) {print(",");}
        }
        str = (yIdx==rows-1)?"}\n":" },\n";
        print(str);
      }
      print(" };\n");
    }
  }

}
  
  void draw(){}
