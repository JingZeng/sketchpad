
import controlP5.*;
ControlP5 cp5;

PGraphics canvas;
PFont font;
Buttons[] brush;
Buttons[] tool;
int switchBtn; 
int tColour; //t-shirt colour
int c = color(100); //brush colour from controlP5
String[] brushCap = {"SQUARE", "CIRCLE", "RINGS", "FRAME", "LINES"};
String[] toolCap = {"CLEAR", "SAVE", "ABOUT"};


void setup(){
  size(1200,700);
  textSize(12); 
  smooth();
  canvas = createGraphics(889,679); //set up canvas
  
  //controlP5_colour wheel
  cp5 = new ControlP5( this );
  cp5.addColorWheel("c" , 50 , 40 , 214 ).setRGB(color(60,0,255));
  noStroke();
      
  //controlP5_toggle for t-shirt colour and canvas colour
  toggle(true);
  cp5.addToggle("toggle")
     .setPosition(230,410)
     .setSize(30,15)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setColorBackground(#000000)
     .setColorActive(#ffffff)
     .setLabel("") 
     ;

  //set up default tool
  drawCircle(canvas);
}



void draw(){
  
  setupSketchpad(); //set up
  image(canvas,301,11); //set up canvas
  

  //brush buttons
  brush = new Buttons[5];
  for (int i=0; i<brush.length; i++){
    fill(0);
    brush[i] = new Buttons(50, i*28+270, 120, 22, brushCap[i]);
    brush[i].draw();
  }
  
  //tool buttons
  tool = new Buttons[3];
  for (int i=0; i<tool.length; i++){
    tool[i] = new Buttons(193, i*40+270, 70, 32, toolCap[i]);
    tool[i].draw();
  }
    
  //controlP5_colour wheel
  fill( c );
  //println(cp5.get(ColorWheel.class,"c").getRGB()); 

  
  //press button to switch tools
  if (mousePressed) {
    switch(switchBtn) {
    
    case 0:
      drawRect(canvas);
      println("draw circles");
      break;
  
    case 1:
      drawCircle(canvas);
      break;
  
    case 2:
      drawRings(canvas);
      break;
  
    case 3:
      drawFrame(canvas);
      break;
  
    case 4:
      drawLine(canvas);
      break;
      
    default:
      drawFrame(canvas);
      break;
    
    
    //switch tools
    //switch(switchTools) {
    
    case 5:
      eraseAll(canvas);
      break;
  
    case 6:
      canvas.save("T-shirt Design "+minute()+second()+".png");
      break;
  
    case 7:
      msgBox();
      break;
    }  
  }
  mouseHover();
  
}  
//////end draw//////


void setupSketchpad(){
  //sketchpad frame
  stroke(0);
  strokeWeight(5);
  rectMode(CORNERS);
  noFill();
  rect(5,5,1195,695);
  strokeWeight(1);
  fill(tColour);
  rect(10,10,1190,690);
  fill(220);
  strokeWeight(2);
  rect(15,15,300,685); 
  
  //T-shirt sample
  drawTshirt(23,425,tColour);
  
  //set up the preview on T-shirt
  pushMatrix();
  scale(0.129);
  translate(100/0.129,480/0.129);
  image(canvas,0,0);
  popMatrix();
  
  //set up canvas 
  canvas.background(255);
  canvas.fill(255);
  canvas.rect(310,10,890,680);

  // toggle grey frame
  strokeWeight(8);
  stroke(150);
  rectMode(CORNER);
  rect(229,410,30,15);  
}


//class button
class Buttons {
  float btnX;
  float btnY;
  float btnWd;
  float btnHt;
  String caption;
  
  Buttons (float _btnX, float _btnY, float _btnWd, float _btnHt, String _caption){
    btnX = _btnX;
    btnY = _btnY;
    btnWd = _btnWd;
    btnHt = _btnHt;
    caption = _caption;
  }
  
  boolean insideBtn(){  //check whether the mouse is on the button
    if (mouseX > btnX && mouseX < btnX+btnWd && mouseY > btnY && mouseY < btnY+btnHt ) {
      return true;  
    } else {
      return false;
    }
  }
  
  void draw(){  //draw buttons
    textAlign(CENTER,CENTER);
    text(caption, btnX+btnWd/2, btnY+btnHt/2); 
    strokeWeight(0.5);
    stroke(0);
    noFill();
    rect(btnX, btnY, btnWd, btnHt);
  }
  
  void highlightBtn(){
    noFill();
    strokeWeight(1.5);
    rect(btnX, btnY, btnWd, btnHt); 
  }
}


////
void mousePressed(){
  for (int i=0; i<brush.length; i++) {
    if (brush[i].insideBtn() == true) {
      switchBtn = i;
      println("brush " + i);
    }
  }
  for (int i=0; i<tool.length; i++) {
    if(tool[i].insideBtn() == true) {
      switchBtn = i+5;
      println("tool " + i+5);
    }
  }
}

////
void mouseHover(){
  for (int i=0; i<brush.length; i++) {
    if (brush[i].insideBtn() == true) {
      brush[i].highlightBtn();
    }
  }
  for (int i=0; i<tool.length; i++) {
    if(tool[i].insideBtn() == true) {
       tool[i].highlightBtn();
    }
  }
}


////
void keyPressed() {
  if(key=='s' || key=='S'){
      canvas.save("T-shirt Design "+minute()+second()+".png");
  }
}


//button 0
void drawRect(PGraphics canvas){
  canvas.beginDraw();
  canvas.fill(c,random(170,200));
  float distance = dist(pmouseX, pmouseY, mouseX, mouseY);
  if (distance < 70) {
    pushMatrix();
    canvas.rotate(random(-PI/90,PI/45));
    canvas.noStroke();
    canvas.rect(mouseX-300, mouseY-10, distance, distance);
    popMatrix();
  }
  canvas.endDraw();
} 


//button 1
void drawCircle(PGraphics canvas){
  canvas.beginDraw();
  float distance = dist(pmouseX, pmouseY, mouseX, mouseY);
  if (distance < 60) {
    canvas.rotate(random(-PI/90,PI/45));
    canvas.noStroke();
    canvas.fill(c,random(170,200));
    canvas.ellipse(mouseX-300, mouseY-10, distance, distance);
  }
  if (distance < 50 && distance >10) {
    canvas.rotate(random(-PI/90,PI/45));
    canvas.noFill();
    canvas.stroke(c);
    canvas.strokeWeight(1);
    canvas.ellipse(mouseX-320, mouseY-30, distance+20, distance+20);
  }
  canvas.endDraw();
} 


//button 2
void drawRings(PGraphics canvas){
  canvas.beginDraw();
  float distance = dist(pmouseX, pmouseY, mouseX, mouseY);
  if (distance < 100 && distance > 20) {
    for (float i=1; i<distance; i *= 1.4){
      canvas.stroke(c);
      canvas.strokeWeight(1);
      canvas.noFill();
      canvas.ellipse(mouseX-300, mouseY-10, i*1.5, i*1.5);
    }
  }
  canvas.endDraw();
}

//button 3
void drawLine(PGraphics canvas){
  canvas.beginDraw();
  for (int i=0; i<6 ; i++){
    canvas.stroke(c);
    canvas.strokeWeight(1);
    canvas.ellipse(mouseX-300 , (mouseY-10)+i*3,3,1);
  }
  canvas.endDraw();
} 


//button 4
void drawFrame(PGraphics canvas){
  canvas.beginDraw();
  float distance = dist(pmouseX, pmouseY, mouseX, mouseY);
  if (distance < 100) {
    pushMatrix();
    canvas.noFill();
    canvas.stroke(c);
    canvas.strokeWeight(1);
    canvas.rotate(random(-PI/90,PI/45));
    canvas.rect(mouseX-300, mouseY-10, distance, distance);
    popMatrix();
  }
  canvas.endDraw();
}   


//button 5 
void eraseAll(PGraphics canvas){
  canvas.beginDraw(); 
  canvas.clear();
  canvas.endDraw();
}

//draw T-shirt
void drawTshirt(float cx, float cy, int tColour){
  pushMatrix();
  translate(cx,cy);
  strokeWeight(1.5);
  stroke(100);
  fill(tColour);
  beginShape();
  vertex(106, 0);
  vertex(56, 18);
  vertex(0, 52);
  vertex(32, 104);
  vertex(60, 98);
  vertex(60, 247);
  vertex(207, 247);
  vertex(207, 98);
  vertex(238, 104);
  vertex(270, 52);
  vertex(215, 18);
  vertex(164, 0);
  endShape(CLOSE);
  bezier(56,18,66,42,68,70,60,98);
  bezier(215,18,205,44,204,74,207,98);
  bezier(98,3,117,25,153,25,170,3);
  bezier(106,0,125,17,144,17,164,0);
  popMatrix();
} 

//toggle for tshirt and canvas colour
void toggle(boolean theFlag) {
  if(theFlag==true) {
    tColour = color(0);
  } else {
    tColour = color(255);
  } 
}

void msgBox(){
  fill(200,60);
  noStroke();
  rect(550,325,300,100);
  fill(0);
  textSize(18); 
  text("SKETCHPAD ON T-SHIRT",700,350);
  textSize(12); 
  text("DESIGNED BY JING ZENG", 700,390);
}