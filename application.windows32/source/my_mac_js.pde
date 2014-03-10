//The MIT License (MIT) - See Licence.txt for details

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies
/* @pjs preload="play.png,pause.png"; */
Maxim maxim;
AudioPlayer sample1,sample2;
AudioPlayer sample3,sample4; 
AudioPlayer sample5,sample6; 
AudioPlayer sample7,sample8;
AudioPlayer sample9,sample10;
AudioPlayer sample11,sample12;

boolean[] track1;
boolean[] track2;
boolean[] track3;
boolean[] track4,track5,track6;

boolean flag = true;
int j = 255;

int playhead;

int numBeats;
int currentBeat;
int buttonWidth;
int buttonHeight;
 


Toggle play,s1,s2,s3,s4,s5,s6,lights;
Slider tempo;
MultiSlider volume;

int marginx = 20;
int marginy = 20;

int c = 0;
boolean m1=true,m2,m3;

void setup() {
  size(1000, 600);
  maxim = new Maxim(this);
  numBeats = 18;
  currentBeat = 0;
  buttonWidth = (width-150)/numBeats;
  buttonHeight = height/12;

  maxim = new Maxim(this);
 
  sample1 = maxim.loadFile("kick1.wav");
  sample1.setLooping(false);
  
  sample2 = maxim.loadFile("kick2.wav");
  sample2.setLooping(false);
  
  sample3 = maxim.loadFile("snare1.wav");
  sample3.setLooping(false);
  
  sample4 = maxim.loadFile("snare2.wav");
  sample4.setLooping(false);
  
  sample5 = maxim.loadFile("clap1.wav");
  sample5.setLooping(false);
  
  sample6 = maxim.loadFile("clap2.wav");
  sample6.setLooping(false);
  
  sample7 = maxim.loadFile("oh1.wav");
  sample7.setLooping(false);
  
  sample8 = maxim.loadFile("oh2.wav");
  sample8.setLooping(false);
  
  sample9 = maxim.loadFile("rs1.wav");
  sample9.setLooping(false);
  
  sample10 = maxim.loadFile("rs2.wav");
  sample10.setLooping(false);
  
  sample11 = maxim.loadFile("beat1.wav");
  sample11.setLooping(false);
  
  sample12= maxim.loadFile("beat2.wav");
  sample12.setLooping(false);

  // set up the sequences
  track1 = new boolean[numBeats];
  track2 = new boolean[numBeats];
  track3 = new boolean[numBeats];
  track4 = new boolean[numBeats];
  track5 = new boolean[numBeats];
  track6 = new boolean[numBeats];
  
  frameRate(40);
  
  PImage Play = loadImage("play.png");
  PImage pause = loadImage("pause.png");
  
  play = new Toggle("Play",width/2,marginy*4,70,70);
  play.setInactiveImage(Play);
  play.setActiveImage(pause);
  play.setActiveColor(color(255,0));
  play.setInactiveColor(color(255,0));
  
  s1 = new Toggle("Kick",marginx,250,buttonWidth + 30,buttonHeight);
  s2 = new Toggle("Snare",marginx,250+buttonHeight,buttonWidth+30,buttonHeight);
  s3 = new Toggle("Clap",marginx,250+buttonHeight*2,buttonWidth+30,buttonHeight);
  s4 = new Toggle("Hi Hat",marginx,250+buttonHeight*3,buttonWidth+30,buttonHeight);
  s5 = new Toggle("Rhythm",marginx,250+buttonHeight*4,buttonWidth+30,buttonHeight);
  s6 = new Toggle("Beat",marginx,250+buttonHeight*5,buttonWidth+30,buttonHeight);
  
  lights = new Toggle("DJ Lights",marginx,height/4,buttonWidth+30,buttonHeight);
  
  s1.setLineColor(255);
  s2.setLineColor(255);
  s3.setLineColor(255);
  s4.setLineColor(255);
  s5.setLineColor(255);
  s6.setLineColor(255);
  lights.setLineColor(255);
  
  //volume = new Slider("Volume",1,0,2,marginx,marginy,100,30,HORIZONTAL);
  tempo = new Slider("Tempo",4,1,10,marginx,marginy+30,200,30,HORIZONTAL);
  //tempo.setLineColor(color(0));
  
  String[] track_v = {"Track 1","Track 2","Track 3","Track 4","Track 5","Track 6"};
  volume = new MultiSlider(track_v.length,0,2.3,width/4,marginy,150,20,HORIZONTAL);
  volume.setNames(track_v);
  volume.set(0,1);
  volume.set(1,1);
  volume.set(2,1);
  volume.set(3,1);
  volume.set(4,1);
  volume.set(5,1);
  
  
  //test the timing
//  for (int i=0;i<track3.length;i++){
  //  track2[i] = true;
    //track3[i] = true;
  //}
  
}

void draw() {
  
    
  background(255);
  
  stroke(100,100,200);
  
  sample1.volume(1 * volume.get(0));
  sample2.volume(1 * volume.get(0));
  sample3.volume(1 * volume.get(1));
  sample4.volume(1 * volume.get(1));
  sample5.volume(1 * volume.get(2));
  sample6.volume(1 * volume.get(2));
  sample7.volume(1 * volume.get(3));
  sample8.volume(1 * volume.get(3));
  sample9.volume(1 * volume.get(4));
  sample10.volume(1 * volume.get(4));
  sample11.volume(1 * volume.get(5));
  sample12.volume(1 * volume.get(5));
  
  noStroke();
  fill(#377EEF,165);
  rect(150,250,buttonWidth*18,buttonHeight*6);
  
  strokeWeight(1.5);
  stroke(255);
  for (int i = 0; i < 7; i++)
    line(150, 250+(i*buttonHeight), 150 + (buttonWidth*18), 250+(i*buttonHeight));
  for (int i = 0; i < numBeats + 1; i++)
    line(150 + i*buttonWidth, 250, 150 + i*buttonWidth, 250+(6*buttonHeight));


  // draw a moving square showing where the sequence is 
  fill(0, 0, 200, 120);
  rect(150 + currentBeat*buttonWidth, 250, buttonWidth, 6*buttonHeight);

  for (int i = 0; i < numBeats; i++)
  {
    strokeWeight(5);
    stroke(#289A2F);
    fill(#8DF0EC);

    if (track1[i])
      rect(150 + i*buttonWidth, 250+(0*buttonHeight), buttonWidth, buttonHeight);
    if (track2[i])
      rect(150 + i*buttonWidth, 250+(1*buttonHeight), buttonWidth, buttonHeight);
    if (track3[i])
      rect(150 + i*buttonWidth, 250+(2*buttonHeight), buttonWidth, buttonHeight);
    if (track4[i])
      rect(150 + i*buttonWidth, 250+(3*buttonHeight), buttonWidth, buttonHeight);
    if (track5[i])
      rect(150 + i*buttonWidth, 250+(4*buttonHeight), buttonWidth, buttonHeight);
    if (track6[i])
      rect(150 + i*buttonWidth, 250+(5*buttonHeight), buttonWidth, buttonHeight);  
  }
float a = map(c,0,90,30,255);
  if(play.get()){
    if(lights.get())
    {
     noStroke();
     pushMatrix();
     translate(0,height);
     rotate(radians(c));
     fill(128,a,0,129);
     triangle(0,0,0,-1700,400,-1700);
     popMatrix();
     
     pushMatrix();
     translate(width/2,0);
     rotate(radians(-c));
     fill(a,128,0,129);
     triangle(0,0,-500,height+300,0,height+300);
     rotate(radians(2*c));
     triangle(0,0,500,height+300,0,height+300);
     popMatrix();
        
        pushMatrix();
        translate(width,height);
        rotate(radians(-c));
        fill(128,12,a,129);
        triangle(0,0,0,-1700,-400,-1700);
        popMatrix();
    }
        
        
    playhead ++;
    //if (frameCount%4==0) {// 4 frames have passed check if we need to play a beat
    if(playhead % (int)tempo.get() == 0){
        
        
      if (track1[currentBeat]) // track1 wants to play on this beat
      {
        if(m1){
          c++;
          if(c==95)
          m1=false;
        }
        else{
          c--;
          if(c==-5)
          m1=true;
        }
        if(s1.get())
        {
        sample1.cue(0);
        sample1.play();
        }
        else
        {
        sample2.cue(0);
        sample2.play();
        }
      }
      if (track2[currentBeat]) {
        if(m1){
          c++;
          if(c==95)
          m1=false;
        }
        else{
          c--;
          if(c==-5)
          m1=true;
        }
        if(s2.get())
        {
        sample3.cue(0);
        sample3.play();
        }
        else
        {
        sample4.cue(0);
        sample4.play();
        }
      }
      if (track3[currentBeat]) {
        if(m1){
          c++;
          if(c==95)
          m1=false;
        }
        else{
          c--;
          if(c==-5)
          m1=true;
        }
        if(s3.get())
        {
        sample5.cue(0);
        sample5.play();
        }
        else
        {
        sample6.cue(0);
        sample6.play();
        }
      }
      if (track4[currentBeat]) {
        if(m1){
          c++;
          if(c==95)
          m1=false;
        }
        else{
          c--;
          if(c==-5)
          m1=true;
        }
        if(s4.get())
        {
        sample7.cue(0);
        sample7.play();
        }
        else
        {
        sample8.cue(0);
        sample8.play();
        }
      }
      if (track5[currentBeat]) {
        if(m1){
          c++;
          if(c==95)
          m1=false;
        }
        else{
          c--;
          if(c==-5)
          m1=true;
        }
        if(s5.get())
        {
        sample9.cue(0);
        sample9.play();
        }
        else
        {
        sample10.cue(0);
        sample10.play();
        }
      }
      if (track6[currentBeat]) {
        if(m1){
          c++;
          if(c==95)
          m1=false;
        }
        else{
          c--;
          if(c==-5)
          m1=true;
        }
        if(s6.get())
        {
        sample11.cue(0);
        sample11.play();
        }
        else
        {
        sample12.cue(0);
        sample12.play();
        }
      }
      // move to the next beat ready for next time
      currentBeat++;
      if (currentBeat >= numBeats)
        currentBeat = 0;
        
    }
   }
  String s;
  if (mouseX>=marginx && mouseX<=marginx+buttonWidth+30 && mouseY>=250 && mouseY<=250+(6*buttonHeight))
    {  s = "Tap to choose the alternative track :)";
      textSize(32);
      text(s,3*width/5,height/10,2*width/5,height/2);
    }
    if(play.isClicked()){
      if(play.get()){
        s = "Pause";
      }
      else s = "Play";
      textSize(32);
      text(s,3*width/5,height/10,2*width/5,height/2);
    }
    if(volume.isClicked()){
      s= "Slide to change the volume of individual Tracks";
      textSize(32);
      text(s,3*width/5,height/10,2*width/5,height/2);
    }
  textSize(16);
  strokeWeight(.5); 
  play.display();
  volume.display();
  tempo.display();
  strokeWeight(1.5);
  s1.display();
  s4.display();
  s3.display();
  s2.display();
  s5.display();
  s6.display();
  lights.display();
  
  if(flag){
    
    textSize(60);
    fill(255);
    rect(0,0,width,height);
    fill(100,180,120,j);
    text("Welcome..",width/2,height/2);
    j-=3;
    if(j<0)
    flag=false;
  }
}

void mousePressed() {
  if(mouseX>150 && mouseY>250 && mouseY<300+buttonHeight * 6)
  {
  int index = (int) Math.floor((mouseX-150)*numBeats/(width-150));   
  int track = (int) Math.floor((mouseY-250)*(12/(float)height));

  //println("index "+index);
  //println("track "+track);


  if (track == 0)
    track1[index] = !track1[index];
  if (track == 1)
    track2[index] = !track2[index];
  if (track == 2)
    track3[index] = !track3[index];
  if (track == 3)
    track4[index] = !track4[index];
  if (track == 4)
    track5[index] = !track5[index];
  if (track == 5)
    track6[index] = !track6[index];
  } 
    volume.mousePressed();
    tempo.mousePressed();
    
}

void mouseReleased(){
  volume.mouseReleased();
  play.mouseReleased();
  tempo.mouseReleased();
  lights.mouseReleased();
  s1.mouseReleased();
  s4.mouseReleased();
  s3.mouseReleased();
  s2.mouseReleased();
  s5.mouseReleased();
  s6.mouseReleased();
}

void mouseDragged(){
  volume.mouseDragged();
  tempo.mouseDragged();
}
  

int HORIZONTAL = 0;
int VERTICAL   = 1;
int UPWARDS    = 2;
int DOWNWARDS  = 3;

class Widget
{

  
  PVector pos;
  PVector extents;
  String name;
  color inactiveColor = color(#40D545);
  color activeColor = color(#3CD3F1);
  color bgColor = inactiveColor;
  color lineColor = color(#6792E7);
  
  
  
  void setInactiveColor(color c)
  {
    inactiveColor = c;
    bgColor = inactiveColor;
  }
  
  color getInactiveColor()
  {
    return inactiveColor;
  }
  
  void setActiveColor(color c)
  {
    activeColor = c;
  }
  
  color getActiveColor()
  {
    return activeColor;
  }
  
  void setLineColor(color c)
  {
    lineColor = c;
  }
  
  color getLineColor()
  {
    return lineColor;
  }
  
  String getName()
  {
    return name;
  }
  
  void setName(String nm)
  {
    name = nm;
  }


  Widget(String t, int x, int y, int w, int h)
  {
    pos = new PVector(x, y);
    extents = new PVector (w, h);
    name = t;
    //registerMethod("mouseEvent", this);
  }

  void display()
  {
  }

  boolean isClicked()
  {
    
    if (mouseX > pos.x && mouseX < pos.x+extents.x 
      && mouseY > pos.y && mouseY < pos.y+extents.y)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  public void mouseEvent(MouseEvent event)
  {
    //if (event.getFlavor() == MouseEvent.PRESS)
    //{
    //  mousePressed();
    //}
  }
  
  
  boolean mousePressed()
  {
    return isClicked();
  }
  
  boolean mouseDragged()
  {
    return isClicked();
  }
  
  
  boolean mouseReleased()
  {
    return isClicked();
  }
}

class Button extends Widget
{
  PImage activeImage = null;
  PImage inactiveImage = null;
  PImage currentImage = null;
  color imageTint = color(255);
  
  Button(String nm, int x, int y, int w, int h)
  {
    super(nm, x, y, w, h);
  }
  
  void setImage(PImage img)
  {
    setInactiveImage(img);
    setActiveImage(img);
  }
  
  void setInactiveImage(PImage img)
  {
    if(currentImage == inactiveImage || currentImage == null)
    {
      inactiveImage = img;
      currentImage = inactiveImage;
    }
    else
    {
      inactiveImage = img;
    }
  }
  
  void setActiveImage(PImage img)
  {
    if(currentImage == activeImage || currentImage == null)
    {
      activeImage = img;
      currentImage = activeImage;
    }
    else
    {
      activeImage = img;
    }
  }
  
  void setImageTint(float r, float g, float b)
  {
    imageTint = color(r,g,b);
  }

  void display()
  {
    if(currentImage != null)
    {
      //float imgHeight = (extents.x*currentImage.height)/currentImage.width;
      float imgWidth = (extents.y*currentImage.width)/currentImage.height;
      
      
      pushStyle();
      imageMode(CORNER);
      tint(imageTint);
      image(currentImage, pos.x, pos.y, imgWidth, extents.y);
      stroke(bgColor);
      noFill();
      rect(pos.x, pos.y, imgWidth,  extents.y);
      noTint();
      popStyle();
    }
    else
    {
      pushStyle();
      stroke(lineColor);
      fill(bgColor);
      rect(pos.x, pos.y, extents.x, extents.y);
  
      fill(lineColor);
      textAlign(CENTER, CENTER);
      text(name, pos.x + 0.5*extents.x, pos.y + 0.5* extents.y);
      popStyle();
    }
  }
  
  boolean mousePressed()
  {
    if (super.mousePressed())
    {
      bgColor = activeColor;
      if(activeImage != null)
        currentImage = activeImage;
      return true;
    }
    return false;
  }
  
  boolean mouseReleased()
  {
    if (super.mouseReleased())
    {
      bgColor = inactiveColor;
      if(inactiveImage != null)
        currentImage = inactiveImage;
      return true;
    }
    return false;
  }
}

class Toggle extends Button
{
  boolean on = false;

  Toggle(String nm, int x, int y, int w, int h)
  {
    super(nm, x, y, w, h);
  }


  boolean get()
  {
    return on;
  }

  void set(boolean val)
  {
    on = val;
    if (on)
    {
      bgColor = activeColor;
      if(activeImage != null)
        currentImage = activeImage;
    }
    else
    {
      bgColor = inactiveColor;
      if(inactiveImage != null)
        currentImage = inactiveImage;
    }
  }

  void toggle()
  {
    set(!on);
  }

  
  boolean mousePressed()
  {
    return super.isClicked();
  }

  boolean mouseReleased()
  {
    if (super.mouseReleased())
    {
      toggle();
      return true;
    }
    return false;
  }
}

class RadioButtons extends Widget
{
  public Toggle [] buttons;
  
  RadioButtons (int numButtons, int x, int y, int w, int h, int orientation)
  {
    super("", x, y, w*numButtons, h);
    buttons = new Toggle[numButtons];
    for (int i = 0; i < buttons.length; i++)
    {
      int bx, by;
      if(orientation == HORIZONTAL)
      {
        bx = x+i*(w+5);
        by = y;
      }
      else
      {
        bx = x;
        by = y+i*(h+5);
      }
      buttons[i] = new Toggle("", bx, by, w, h);
    }
  }
  
  void setNames(String [] names)
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(i >= names.length)
        break;
      buttons[i].setName(names[i]);
    }
  }
  
  void setImage(int i, PImage img)
  {
    setInactiveImage(i, img);
    setActiveImage(i, img);
  }
  
  void setAllImages(PImage img)
  {
    setAllInactiveImages(img);
    setAllActiveImages(img);
  }
  
  void setInactiveImage(int i, PImage img)
  {
    buttons[i].setInactiveImage(img);
  }

  
  void setAllInactiveImages(PImage img)
  {
    for (int i = 0; i < buttons.length; i++)
    {
      buttons[i].setInactiveImage(img);
    }
  }
  
  void setActiveImage(int i, PImage img)
  {
    buttons[i].setActiveImage(img);
  }
  
  
  
  void setAllActiveImages(PImage img)
  {
    for (int i = 0; i < buttons.length; i++)
    {
      buttons[i].setActiveImage(img);
    }
  }

  void set(String buttonName)
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].getName().equals(buttonName))
      {
        buttons[i].set(true);
      }
      else
      {
        buttons[i].set(false);
      }
    }
  }
  
  int get()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].get())
      {
        return i;
      }
    }
    return -1;
  }
  
  String getString()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].get())
      {
        return buttons[i].getName();
      }
    }
    return "";
  }

  void display()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      buttons[i].display();
    }
  }

  boolean mousePressed()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].mousePressed())
      {
        return true;
      }
    }
    return false;
  }
  
  boolean mouseDragged()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].mouseDragged())
      {
        return true;
      }
    }
    return false;
  }

  boolean mouseReleased()
  {
    for (int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].mouseReleased())
      {
        for(int j = 0; j < buttons.length; j++)
        {
          if(i != j)
            buttons[j].set(false);
        }
        //buttons[i].set(true);
        return true;
      }
    }
    return false;
  }
}

class Slider extends Widget
{
  float minimum;
  float maximum;
  float val;
  int textWidth = 60;
  int orientation = HORIZONTAL;

  Slider(String nm, float v, float min, float max, int x, int y, int w, int h, int ori)
  {
    super(nm, x, y, w, h);
    val = v;
    minimum = min;
    maximum = max;
    orientation = ori;
    if(orientation == HORIZONTAL)
      textWidth = 60;
    else
      textWidth = 20;
    
  }

  float get()
  {
    return val;
  }

  void set(float v)
  {
    val = v;
    val = constrain(val, minimum, maximum);
  }

  void display()
  {
    
    float textW = textWidth;
    if(name == "")
      textW = 0;
    pushStyle();
    textAlign(LEFT, TOP);
    fill(lineColor);
    text(name, pos.x, pos.y);
    stroke(lineColor);
    noFill();
    if(orientation ==  HORIZONTAL){
      rect(pos.x+textW, pos.y, extents.x-textWidth, extents.y,10);
    } else {
      rect(pos.x, pos.y+textW, extents.x, extents.y-textW,10);
    }
    noStroke();
    fill(bgColor);
    float sliderPos; 
    if(orientation ==  HORIZONTAL){
        sliderPos = map(val, minimum, maximum, 0, extents.x-textW-4); 
        rect(pos.x+textW+2, pos.y+2, sliderPos, extents.y-4,10);
    } else if(orientation ==  VERTICAL || orientation == DOWNWARDS){
        sliderPos = map(val, minimum, maximum, 0, extents.y-textW-4); 
        rect(pos.x+2, pos.y+textW+2, extents.x-4, sliderPos,10);
    } else if(orientation == UPWARDS){
        sliderPos = map(val, minimum, maximum, 0, extents.y-textW-4); 
        rect(pos.x+2, pos.y+textW+2 + (extents.y-textW-4-sliderPos), extents.x-4, sliderPos,10);
    };
    popStyle();
  }

  
  boolean mouseDragged()
  {
    if (super.mouseDragged())
    {
      float textW = textWidth;
      if(name == "")
        textW = 0;
      if(orientation ==  HORIZONTAL){
        set(map(mouseX, pos.x+textW, pos.x+extents.x-4, minimum, maximum));
      } else if(orientation ==  VERTICAL || orientation == DOWNWARDS){
        set(map(mouseY, pos.y+textW, pos.y+extents.y-4, minimum, maximum));
      } else if(orientation == UPWARDS){
        set(map(mouseY, pos.y+textW, pos.y+extents.y-4, maximum, minimum));
      };
      return true;
    }
    return false;
  }

  boolean mouseReleased()
  {
    if (super.mouseReleased())
    {
      float textW = textWidth;
      if(name == "")
        textW = 0;
      if(orientation ==  HORIZONTAL){
        set(map(mouseX, pos.x+textW, pos.x+extents.x-10, minimum, maximum));
      } else if(orientation ==  VERTICAL || orientation == DOWNWARDS){
        set(map(mouseY, pos.y+textW, pos.y+extents.y-10, minimum, maximum));
      } else if(orientation == UPWARDS){
        set(map(mouseY, pos.y+textW, pos.y+extents.y-10, maximum, minimum));
      };
      return true;
    }
    return false;
  }
}

class MultiSlider extends Widget
{
  Slider [] sliders;
  /*
  MultiSlider(String [] nm, float min, float max, int x, int y, int w, int h, int orientation)
  {
    super(nm[0], x, y, w, h*nm.length);
    sliders = new Slider[nm.length];
    for (int i = 0; i < sliders.length; i++)
    {
      int bx, by;
      if(orientation == HORIZONTAL)
      {
        bx = x;
        by = y+i*h;
      }
      else
      {
        bx = x+i*w;
        by = y;
      }
      sliders[i] = new Slider(nm[i], 0, min, max, bx, by, w, h, orientation);
    }
  }
  */
  MultiSlider(int numSliders, float min, float max, int x, int y, int w, int h, int orientation)
  {
    super("", x, y, w, h*numSliders);
    sliders = new Slider[numSliders];
    for (int i = 0; i < sliders.length; i++)
    {
      int bx, by;
      if(orientation == HORIZONTAL)
      {
        bx = x;
        by = y+i*h;
      }
      else
      {
        bx = x+i*w;
        by = y;
      }
      sliders[i] = new Slider("", 0, min, max, bx, by, w, h, orientation);
    }
  }
  
  void setNames(String [] names)
  {
    for (int i = 0; i < sliders.length; i++)
    {
      if(i >= names.length)
        break;
      sliders[i].setName(names[i]);
    }
  }

  void set(int i, float v)
  {
    if(i >= 0 && i < sliders.length)
    {
      sliders[i].set(v);
    }
  }
  
  float get(int i)
  {
    if(i >= 0 && i < sliders.length)
    {
      return sliders[i].get();
    }
    else
    {
      return -1;
    }
    
  }

  void display()
  {
    for (int i = 0; i < sliders.length; i++)
    {
      sliders[i].display();
    }
  }

  
  boolean mouseDragged()
  {
    for (int i = 0; i < sliders.length; i++)
    {
      if(sliders[i].mouseDragged())
      {
        return true;
      }
    }
    return false;
  }

  boolean mouseReleased()
  {
    for (int i = 0; i < sliders.length; i++)
    {
      if(sliders[i].mouseReleased())
      {
        return true;
      }
    }
    return false;
  }
}


