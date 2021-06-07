int dl  = 100;
PImage img;
int count=0;
String blockName[]= {"blockI","blockJ","blockL","blockO","blockS","blockT","blockZ"};
//int panelSize=500;
void drawBlock(int idx)
{
  //draw block
  rectMode(CENTER);
  switch (idx)
  {
    case 2:
      fill(255,150,  0);            //L orange
      rect(250,250,dl,dl);
      rect(250,350,dl,dl);
      rect(350,350,dl,dl);
      rect(450,350,dl,dl);
      saveFrame(blockName[idx]+"0.png");
      break;
    case 3:
      fill(128,  0,128);            //O purple
      rect(250,250,dl,dl);
      rect(250,350,dl,dl);
      rect(350,250,dl,dl);
      rect(350,350,dl,dl);
      saveFrame(blockName[idx]+"0.png");
      break;
    case 6:
      fill(  0,128,  0);            //Z olive
      rect(250,250,dl,dl);
      rect(350,150,dl,dl);
      rect(350,250,dl,dl);
      rect(250,350,dl,dl);
      saveFrame(blockName[idx]+"0.png");
      break;
    case 4:
      fill(200,  0,200);            //S pink
      rect(250,150,dl,dl);
      rect(350,250,dl,dl);
      rect(250,250,dl,dl);
      rect(350,350,dl,dl);
      saveFrame(blockName[idx]+"0.png");
      break;
    case 5:
      fill(  0,128,128);            //T teal
      rect(250,150,dl,dl);
      rect(250,250,dl,dl);
      rect(250,350,dl,dl);
      rect(350,250,dl,dl);
      saveFrame(blockName[idx]+"0.png");
      break;
    case 0:
      fill(255,  0,  0);            //I red
      rect(150,250,dl,dl);
      rect(250,250,dl,dl);
      rect(350,250,dl,dl);
      rect(450,250,dl,dl);
      saveFrame(blockName[idx]+"0.png");
      break;
    case 1:
      fill(255,255,  0);            //J orange
      rect(250,250,dl,dl);
      rect(350,250,dl,dl);
      rect(450,250,dl,dl);
      rect(250,350,dl,dl);
      saveFrame(blockName[idx]+"0.png");
      break;
  }
  
}

void setup()
{
  //fullScreen();
  imageMode(CENTER);
  size(600,600);
  background(255,0);
      
  for (int idx=0; idx<6; idx++)    //==========================block names
  {
    background(255,0);
    drawBlock(idx);
    delay(500);
    for (int i=1;i<4;i++)          //==========================rotated images
    {
      background(255,0);
      translate(300,300);
      rotate(radians(90));
      translate(-300,-300);
      String preImg = blockName[idx]+str(i-1)+".png";
      String curImg = blockName[idx]+str(i)+".png";
      img = loadImage(preImg);
      //delay(1000);
      imageMode(CENTER);
      image(img,300,300);
      saveFrame(curImg);
      translate(300,300);
      rotate(radians(-90));
      translate(-300,-300);
      
      delay(1000);
    }
  }
}


void loop(){}
