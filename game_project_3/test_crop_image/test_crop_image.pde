/* HYOYEON LEE 2021.06.24 
coding for cropping an image and save it
*/
String bg_fname = "bg.png"; 
String crop_fname = "crop.png";
String bg_new_fname = "bg_new.png"; 
PImage img_bg,img_crop,img_bg_new;
int rows,cols;
int xIdx,yIdx,cIdx;
void setup()
{
  size(600,720);
  rows=width/20;
  cols=height/20;
  background(255);
   imageMode(CENTER);
  img_bg = loadImage(bg_fname);
  image(img_bg,width/2,height/2,width,height);
  cIdx = 29;
  img_crop = img_bg.get(120,0,width-240,height-20*(36-cIdx));
  img_crop.save(crop_fname);
  imageMode(CORNER);
  image(img_crop,120,20,width-240,height-20*(36-cIdx+1));
}
void loop(){}
/*
  count_lines = update_bg_state(type,rot,x,y);
     if(count_lines>0)
     {
       for(int i=0;i<count_lines;i++)
       {
         saveFrame(bg_fname);
         clear(cLines[i]);
       }
       count_lines=0;
     }   
     */
