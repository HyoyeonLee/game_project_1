int dl  = 100;
PImage img;
int count=0;
String blockName[]= {"blockL","blockO","blockZ","blockS","blockT","blockI"};
//int panelSize=500;
void drawBlock(int idx)
{
  //draw block
  
  switch (idx)
  {
    case 0:
      fill(255,150,  0);            //L orange
      rect(  0+100,200+100,dl,dl);
      rect(100+100,  0+100,dl,dl);
      rect(100+100,100+100,dl,dl);
      rect(100+100,200+100,dl,dl);
      saveFrame(blockName[idx]+"0.jpg");
      break;
    case 1:
      fill(128,  0,128);            //O purple
      rect(  0+150,  0+150,dl,dl);
      rect(  0+150,100+150,dl,dl);
      rect(100+150,  0+150,dl,dl);
      rect(100+150,100+150,dl,dl);
      saveFrame(blockName[idx]+"0.jpg");
      break;
    case 2:
      fill(  0,128,  0);            //Z olive
      rect(  0+100,100+100,dl,dl);
      rect(100+100,100+100,dl,dl);
      rect(100+100,200+100,dl,dl);
      rect(200+100,200+100,dl,dl);
      saveFrame(blockName[idx]+"0.jpg");
      break;
    case 3:
      fill(200,  0,200);            //S pink
      rect(  0+100,200+100,dl,dl);
      rect(100+100,100+100,dl,dl);
      rect(100+100,200+100,dl,dl);
      rect(200+100,100+100,dl,dl);
      saveFrame(blockName[idx]+"0.jpg");
      break;
    case 4:
      fill(  0,128,128);            //T teal
      rect(  0+100,100+100,dl,dl);
      rect(100+100,  0+100,dl,dl);
      rect(100+100,100+100,dl,dl);
      rect(100+100,200+100,dl,dl);
      saveFrame(blockName[idx]+"0.jpg");
      break;
    case 5:
      fill(255,  0,  0);            //I red
      rect(200, 50,dl,dl);
      rect(200,150,dl,dl);
      rect(200,250,dl,dl);
      rect(200,350,dl,dl);
      saveFrame(blockName[idx]+"0.jpg");
      break;
  }
  
}

void setup()
{
  //fullScreen();
  //noStroke();
  imageMode(CORNER);
  rectMode(CORNER); 
  size(500,500);
  background(255);
      
  for (int idx=0; idx<6; idx++)    //==========================block names
  {
    background(255);
    drawBlock(idx);
    delay(500);
    for (int i=1;i<4;i++)          //==========================rotated images
    {
      background(255);
      translate(250,250);
      rotate(radians(90));
      translate(-250,-250);
      String preImg = blockName[idx]+str(i-1)+".jpg";
      String curImg = blockName[idx]+str(i  )+".jpg";
      img = loadImage(preImg);
      imageMode(CENTER);
      image(img,250,250);
      
      saveFrame(curImg);
      delay(500);
    }
  }
}


void loop(){}
