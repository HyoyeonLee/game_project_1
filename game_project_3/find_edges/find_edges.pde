PImage img;
int cols=6,rows=6;
int[][] state = new int[cols][rows];
char blk_names[] = {'L','O','I','T','Z','S'};
String fpath = "../building_blocks/";
color w=color(255,255,255);
color fig;
int unit = 20; //panelL : 600-->120 ,  unit length : 100-->20
int xL,xR,yB;
int xL0=width-unit/2, xR0=unit/2,yB0=unit/2;


void setup()
{  
  size(120,120);
  background(255);
  imageMode(CENTER);
  xL=xL0;
  xR=xR0;
  yB=yB0;
  for(int i=0;i<rows;i++){  
    for (int j=0;j<cols;j++){
        state[i][j]=0;
      }
  }
  println("type_rot :\t bottom(yB),left(xL),right(xR)");
  for(int type=0;type<6;type++)
  {
    print("{");
    for(int rot=0;rot<4;rot++)
    {
      print("{");
      xL=xL0;
      xR=xR0;
      yB=yB0;
      background(255);
      String fname=fpath+"block"+blk_names[type]+str(rot)+".png";
      img = loadImage(fname);
      image(img,width/2,height/2,width,height);
      for (int i=0;i<rows;i++)
      {
        for(int j=0;j<cols;j++)
        {
          fig = get(unit/2+i*unit,unit/2+j*unit);
          if (red(fig)>100 && green(fig)>100 && blue(fig)>100){state[i][j]=0;}//means white
          else {
            //String str1="(rgb)=("+(int)red(fig)+","+(int)green(fig)+","+(int)blue(fig)+")";
            //println(str1);
            state[i][j]=1;
            if(i>yB)yB=i;
            if(j<xL)xL=j;
            if(j>xR)xR=j;
          }
        }
      }
      String str = str(yB+1-unit/2)+","+str(-unit/2+xL)+","+str(xR+1-unit/2)+"},";
      print(str);
    }
    println("},");
  }
}
  
  void draw(){}
