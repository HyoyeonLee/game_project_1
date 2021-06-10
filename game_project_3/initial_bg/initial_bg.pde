String bg_fname = "bg.png"; //  
String str;
void setup()
{
  println(width);
  size(400,620);
  background(255);
  rectMode(CORNER);
  fill(0,0,0);
  rect(0,0,20,height);
  rect(0,height-20,width,height);
  rect(width-20,0,width,height);
  saveFrame(bg_fname);
  int cols = width/20;
  int rows = height/20;
  int[][] bg_state = new int[rows][cols];
  for(int yIdx=0;yIdx<rows;yIdx++)
  {
    for(int xIdx=0;xIdx<cols;xIdx++)
    {
      int val;
      if(yIdx==rows-1 || xIdx==0 || xIdx==cols-1)val=1;
      else val=0;
      bg_state[yIdx][xIdx]=val;
    }
  }
  println("BG = {");
  for(int yIdx=0;yIdx<rows;yIdx++)
  {
    print("{");
    for(int xIdx=0;xIdx<cols;xIdx++)
    {
      print(bg_state[yIdx][xIdx]);
      if(xIdx!=cols-1)print(",");
    }
    print("}");
    if(yIdx!=rows-1)print(",");
    print("\n");
  }
  println("};");
  
  
  
}
 void draw(){}
