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


void setup()
{  
  size(120,120);
  background(255);
  imageMode(CENTER);
  iB=iB0;
  jL=jL0;
  jR=jR0;
  for(int i=0;i<rows;i++){  
    for (int j=0;j<cols;j++){
        state[i][j]=0;
      }
  }
  println("type_rot :\t bottom(iB),left(jL),right(jR)");
  for(int type=0;type<7;type++)
  {
    print("{");
    for(int rot=0;rot<4;rot++)
    {
      print("{");
      iB=iB0;
      jL=jL0;
      jR=jR0;     
      background(255);
      String fname=fpath+"block"+blk_names[type]+str(rot)+".png";
      img = loadImage(fname);
      image(img,width/2,height/2,width,height);
      for (int i=0;i<rows;i++)
      {
        for(int j=0;j<cols;j++)
        {
          fig = get(unit/2+j*unit,unit/2+i*unit);
          if (red(fig)>100 && green(fig)>100 && blue(fig)>100){state[i][j]=0;}//means white
          else {
            state[i][j]=1;
            if(i>iB)iB=i;
            if(j<jL)jL=j;
            if(j>jR)jR=j;
          }
        }
      }
      String str = str((iB+1)*unit-60)+","+str(60-jL*unit)+","+str((jR+1)*unit-60)+"},";
      print(str);
    }
    println("},");
  }
}
  
  void draw(){}
