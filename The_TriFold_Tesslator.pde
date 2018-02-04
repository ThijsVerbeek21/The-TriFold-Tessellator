//Welcome to Trifold Tessalator, a generative bag maker.
//(C) Loe Feijs, Troy Nachtigall TU/e 2018           
//based upon the Solemaker code by Loe Feijs, Troy Nachtigall and Bart Pruijmboom TU/e 2018.



import processing.pdf.*;
import geomerative.*;
String SVGShape = "frontPanel.svg";
PGraphicsPDF pdf;
int xSize = 1050;
int ySize = 600;
int xBox = 100;
int yBox =100;
int xBoxInit = 100;
int yBoxInit =100;
int xCenter = xSize/2;
int yCenter = ySize/2;
int [][] teslPoint = new int[200][2];
int [][] teslPoint2 = new int[200][2];
int teslPointCtr = 14; //Counter for Tesl Points to speed up the draw
PShape s; //the main tesselation
PShape reverse; //the main tesselation
PShape frontPanel;
int mode = 0; //What are we doing
int TESL = 0;
int cntr = 0; //Framecount
int teslStep = 1;// scaling for zoom
int incline = 0;
int bagScale = 4;
int xScale = 1000;
int yScale = 100;
float teslScale = 1;
void setup() {
  size(xSize, ySize, P2D);
  frontPanel = loadShape(SVGShape);
  frontPanel.disableStyle();
  stroke(0, 0, 255);
  //frontPanel.noFill();
  teslPoint [0][0] = xCenter;// Set the first box.
  teslPoint [0][1] = yCenter - yBox/2;

  teslPoint [1][0] = xCenter + xBox/2;
  teslPoint [1][1] = yCenter;

  teslPoint [2][0] = xCenter + xBox/2;
  teslPoint [2][1] = yCenter + yBox/4;

  teslPoint [3][0] = xCenter + xBox/2 + xBox/4;
  teslPoint [3][1] = yCenter + yBox/2;

  teslPoint [4][0] = xCenter + xBox/2;
  teslPoint [4][1] = yCenter + yBox/2;

  teslPoint [5][0] = xCenter + xBox/2;
  teslPoint [5][1] = yCenter + yBox/2 + yBox/4;

  teslPoint [6][0] = xCenter + xBox/4;
  teslPoint [6][1] = yCenter + yBox/2;

  teslPoint [7][0] = xCenter;
  teslPoint [7][1] = yCenter + yBox/2;

  teslPoint [8][0] = xCenter - xBox/2;
  teslPoint [8][1] = yCenter;

  teslPoint [9][0] = xCenter - xBox/4;
  teslPoint [9][1] = yCenter;

  teslPoint [10][0] = xCenter;
  teslPoint [10][1] = yCenter + yBox/4;

  teslPoint [11][0] = xCenter;
  teslPoint [11][1] = yCenter;

  teslPoint [12][0] = xCenter + xBox/4;
  teslPoint [12][1] = yCenter;

  teslPoint [13][0] = xCenter ;
  teslPoint [13][1] = yCenter - yBox/4;



  for (int i = 14; i < teslPoint.length; i++) {//fill the rest with 0
    teslPoint [i][0]=0;
    teslPoint [i][1]=0;
  }
  for (int i = 0; i < teslPoint.length; i++) {//fill the rest with 0 //Check the array
    print(teslPoint [i][0] + "," + teslPoint [i][1] + " ");
  }
  println();
  shapeMake();
  update();
    instructions();

}
void draw() {
  if (mousePressed && mode == TESL) {
    //find the contour point closest to the mouse.
    float min = 10000;
    float min2 = 10000;
    int whichPoint = -1;
    int whichPoint2 = -1;
    for (int i = 0; i < teslPointCtr; i++) {
      float d = dist(teslPoint[i][0], teslPoint[i][1], mouseX, mouseY);
      if (d < min) {
        min2 = min;
        min = d;
        whichPoint2 = whichPoint;
        whichPoint = i;
      }
    }
    //if there is one point really "near" the mouse then drag it:
    //int near = (teslPoint > 5? 20 : 40);
    if (min < 10) {
      teslPoint[whichPoint][0] = mouseX;
      teslPoint[whichPoint][1] = mouseY;
      shapeMake();
      update();
    } else {


      print (whichPoint + ", " + whichPoint2 + " ");
      if (whichPoint==teslPointCtr-1 && whichPoint==0) {
        teslPointCtr++;
        update();
      } else if (whichPoint==0 && whichPoint2 == teslPointCtr-1) {
        println("New Point 0-");
        for (int i = teslPointCtr; i >= whichPoint; i--) {          
          teslPoint [i][0] = teslPoint [i-1][0];
          teslPoint [i][1] = teslPoint [i-1][1];
          teslPointCtr++;
          //update();
        }
      } else if  (whichPoint<whichPoint2) {
        println("New Point -");
        for (int i = teslPointCtr; i >= whichPoint; i--) {          
          teslPoint [i][0] = teslPoint [i-1][0];
          teslPoint [i][1] = teslPoint [i-1][1];
        }
        teslPoint[whichPoint][0] = mouseX;
        teslPoint[whichPoint][1] = mouseY;
        teslPointCtr++;
        // update();
      } else {
        println("New Point +");
        for (int i = teslPointCtr; i > whichPoint; i--) {          
          teslPoint [i][0] = teslPoint [i-1][0];
          teslPoint [i][1] = teslPoint [i-1][1];
        }
        teslPoint[whichPoint][0] = mouseX;
        teslPoint[whichPoint][1] = mouseY;
        teslPointCtr++;
        update();
      }
    }
  } //end mousepressed
}

void update () {
  background(255);
  int xStep = xSize/xBox/2+2;
  int yStep = ySize/yBox/2+2;
  cntr++;
  //println(xStep+ "," + yStep + ", " + cntr + " " + teslPointCtr);
  stroke(0, 0, 255);
  line (xCenter + xBox/2, 0, xCenter + xBox/2, ySize);//Teselation Guide
  line (xCenter - xBox/2, 0, xCenter - xBox/2, ySize);  
  stroke(0, 255, 0);
  line (0, yCenter - yBox/2, xSize, yCenter - yBox/2);
  line (0, yCenter + yBox/2, xSize, yCenter + yBox/2);

  fill(255);
  noStroke();
  for (int i = 0; i < xStep; i++) {//need to add a detection if the tesselation is on the page.
    for (int j = 0; j < yStep+3; j=j+2) {
      shape(s, i*xBox, j*yBox-incline*i);
      shape(s, -i*xBox, -j*yBox+incline*i);
      shape(s, i*xBox, -j*yBox-incline*i);
      shape(s, -i*xBox, j*yBox+incline*i);
      shape(s, i*xBox, (j+1)*yBox-incline*i);
      shape(s, -i*xBox, (-j-1)*yBox+incline*i);
      shape(s, i*xBox, (-j-1)*yBox-incline*i);
      shape(s, -i*xBox, (j+1)*yBox+incline*i);
      //print(i*xBox + "," + j*yBox + " ");
    }
  }
  stroke (255, 0, 0);
  for (int i = 0; i < teslPointCtr; i++) {
    ellipse(teslPoint [i][0], teslPoint [i][1], 3, 3);
    fill(255, 0, 255);
    text (i, teslPoint [i][0]+3, teslPoint [i][1]);
  }
  //println();
}
void updateDraw () {
  background(255);
  int xStep = xSize/xBox/2+5;//add extras Rows here. 
  int yStep = ySize/yBox/2+5;//add extras Collumns here.
  stroke(0, 0, 255);
  fill(0, 0, 255);
  shape(frontPanel, -13, 10, xSize*.90, ySize*.98);
  //println(xStep+ "," + yStep + ", " + cntr + " " + teslPointCtr);

  fill(255);
  noStroke();
  for (int i = 0; i < xStep; i++) {
    for (int j = 0; j < yStep+3; j=j+2) {
      shape(s, i*xBox, j*yBox-incline*i);
      shape(s, -i*xBox, -j*yBox+incline*i);
      shape(s, i*xBox, -j*yBox-incline*i);
      shape(s, -i*xBox, j*yBox+incline*i);
      shape(s, i*xBox, (j+1)*yBox-incline*i);
      shape(s, -i*xBox, (-j-1)*yBox+incline*i);
      shape(s, i*xBox, (-j-1)*yBox-incline*i);
      shape(s, -i*xBox, (j+1)*yBox+incline*i);
      //print(i*xBox + "," + j*yBox + " ");
    }
  }
  stroke(0, 255, 255);
  line (xSize - 10, 0+5,  xSize - 10, ySize-5);// Side Panel
  line (xSize - 10 - xSize*.08 , 0+5,  xSize - 10 - xSize*.08, ySize-5); 
  line (xSize - 10 - xSize*.08, 0+5, xSize - 10 ,0+5);
  line (xSize - 10 - xSize*.08, ySize-5, xSize - 10, ySize-5);
  //println();
}

void mouseClicked() {
  ellipse(mouseX, mouseY, 3, 3);
  if (mousePressed && mode == TESL) {
    //find the contour point closest to the mouse.
    float min = 10000;
    int whichPoint = -1;
    for (int i = 0; i < teslPointCtr; i++) {
      float d = dist(teslPoint[i][0], teslPoint[i][1], mouseX, mouseY);
      if (d < min) {
        min = d;
        whichPoint = i;
      }
    }
    //if there is one point really "near" the mouse then drag it:
    //int near = (teslPoint > 5? 20 : 40);

    teslPoint[whichPoint][0] = mouseX;
    teslPoint[whichPoint][1] = mouseY;
    update();
  }   //end if mousepressed
}

void keyPressed()
{
  if (keyCode == UP) {
    yBox = yBox+teslStep;
    update();
    println("UP");
  } else if (keyCode == DOWN) {
    yBox = yBox-teslStep;
    update();
    println("DOWN");
  } else if (keyCode == LEFT) {
    xBox = xBox-teslStep;
    update();
    println("LEFT");
  } else if (keyCode == RIGHT) {
    xBox = xBox+teslStep;
    update();
    println("RIGHT");
  } else if (keyCode == '.') {
    incline = incline-teslStep;
    updateDraw();
    println(incline + " Slide Left");
  } else if (keyCode == ',') {
    incline = incline+teslStep;
    updateDraw();
    println(incline + " Slide Right");
  } 
  if (key == 'p'|| key == 'P') {
    pdf = (PGraphicsPDF) beginRecord(PDF, "FrontPanel####.pdf");
    updateDraw();
    endRecord(); 
    println(" Exported");
  }
  if (key == 's'|| key == 'S') {
    teslScale = teslScale - 0.01;
    xBox = int(xBoxInit * teslScale);
    yBox = int(yBoxInit * teslScale);
    s.resetMatrix();
    s.scale(teslScale);
    updateDraw(); 
    println(teslScale + ", xBox:" + xBox + ", yBox:" + yBox);
  }
  if (key == 'l'|| key == 'L') {
    teslScale = teslScale + 0.01;   
    xBox = int(xBoxInit * teslScale);
    yBox = int(yBoxInit * teslScale);
    s.resetMatrix();
    s.scale(teslScale);
    updateDraw(); 
    println(teslScale + ", xBox:" + xBox + ", yBox:" + yBox);
  }
}

void shapeMake() {
  s = createShape();//Make the teslation Module
  s.beginShape();
  s.fill(0);
  s.noStroke();
  for (int i = 0; i < teslPointCtr; i++) {
    s.vertex(teslPoint [i][0], teslPoint [i][1]);
    print(teslPoint [i][0] + "," + teslPoint [i][1] + " ");
  }
  println();
  s.endShape(CLOSE);
}
void instructions(){
println("Adjust the center module slowly, clicking on the lines will add points.");
println("Use the arrow keys to adjust spacing.");
println("Use the , and . keys to adjust incline.");
println("Use the s and l keys to adjust the size of the pattern.");
println("Press p to create a PDF to laser cut. Enlarge it 190%");

}
