/*
  Ladder Logic Simulator V3.2
 June 2020
 By: Kelly Jellison - kelly.jellison@gmail.com
 
 It's dirty messy code but it works.
 For non-commercial, not-for-profit, non-private, educational purposes only!
 
 V2.0 added Coil Information Panel
 V2.1 added Input Information Panel
 V3.0 added scrollable ladder table which makes it infinately more useful.
 V3.1 fixed element nodes and energized states not updating unless on screen
 V3.2 cleaned up code(a bit), adjusted draw dimensions to be relative for resizing 16:9 AR
 
 TODO:   Labels - Add a label to a coil or input and any contacts attached should have that same label
 Outputs - "Y" Output indicators, able to attach to a coil to see its state at all times
 Input toggle toggle - Change whether an input is "toggled" or "momentary"
 Save/Load - Write out a table of rungs/elements with a key for attachments.
 */
float version = 3.2;
float tableborderpositionx;
float tableborderpositiony;
float tablebordersizex;
float tablebordersizey;
float tablepositionx;
float tablepositiony;
float tablesizex;
float tablesizey;
float boundaryspace = 5;
float borderwidth = 50;
float spacer = 20;
float controlpanelpositionx;
float controlpanelpositiony;
float controlpanelsizex;
float controlpanelsizey;
float coilinfopanelpositionx;
float coilinfopanelpositiony;
float coilinfopanelsizex;
float coilinfopanelsizey;
float inputpanelpositionx;
float inputpanelpositiony;
float inputpanelsizex;
float inputpanelsizey;
float buttonsizex;
float buttonsizey;
float elementsize;
float w = 1600, h = 900;
int maxvisiblerungs = 10;
int maxelements = 17;
int visiblerungsindex = 0;
int visiblerungsmaxindex = 0;
String saved = "";
String typing = "";
int strlngth;

ArrayList<rung> rungs = new ArrayList<rung>();
ArrayList<button> inputbuttons = new ArrayList<button>();
ArrayList<element> selectedelements = new ArrayList<element>();
ArrayList<button> inputstoggledon = new ArrayList<button>();
ArrayList<rung> visiblerungs = new ArrayList<rung>();
button wirebutton, nocbutton, nccbutton, coilbutton, bnchdnbutton, bnchupbutton, blankbutton, attachcoilbutton, attachinputbutton, detachinputbutton, detachallinputbutton, cleareverythingbutton, addrungbutton, removerungbutton, scrollupbutton, scrolldownbutton;
debug deb;

void setup() {
  //WINDOW SETUP------------------------------------------------------
  surface.setSize(1600, 900); //1050,700
  surface.setTitle("Ladder Logic V"+str(version));
  surface.setResizable(false);
  surface.setLocation(100, 100);
  //LADDER TABLE------------------------------------------------------
  tablebordersizex = (width/3)*2;
  tablebordersizey = (height/3)*2;
  tableborderpositionx = (width/2)-(tablebordersizex/2);
  tableborderpositiony = boundaryspace;
  tablesizex = tablebordersizex-50;
  tablesizey = tablebordersizey-boundaryspace;
  tablepositionx = tableborderpositionx+50;
  tablepositiony = tableborderpositiony+tablesizey/20;
  elementsize = (tablesizex-60)/20+8;
  //CONTROL PANEL ----------------------------------------------------
  controlpanelsizex = width-boundaryspace*2;
  controlpanelsizey = (height-tablebordersizey-boundaryspace*3);
  controlpanelpositionx = boundaryspace;
  controlpanelpositiony = height-controlpanelsizey-boundaryspace;
  buttonsizex = controlpanelsizex/12;
  buttonsizey = controlpanelsizey/2;
  //COIL INFORMATION PANEL -------------------------------------------
  coilinfopanelpositionx = tableborderpositionx+tablebordersizex+boundaryspace;
  coilinfopanelpositiony = boundaryspace;
  coilinfopanelsizex = width-tablebordersizex-(width/3)/2-boundaryspace*2;
  coilinfopanelsizey = tablebordersizey;
  //INPUT INFORMATION PANEL ------------------------------------------
  inputpanelpositionx = boundaryspace;
  inputpanelpositiony = boundaryspace;
  inputpanelsizex = width-tablebordersizex-(width/3)/2-boundaryspace*2;
  inputpanelsizey = tablebordersizey;
  //BUTTON SETUP------------------------------------------------------
  scrollupbutton = new button(controlpanelpositionx+buttonsizex*0, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 15, 0);
  scrolldownbutton = new button(controlpanelpositionx+buttonsizex*0, controlpanelpositiony+controlpanelsizey/2, controlpanelsizex/12, controlpanelsizey/2, 16, 0);
  wirebutton = new button(controlpanelpositionx+buttonsizex*1, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 1, 0);
  nocbutton = new button(controlpanelpositionx+buttonsizex*2, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 2, 0);
  nccbutton = new button(controlpanelpositionx+buttonsizex*3, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 3, 0);
  coilbutton = new button(controlpanelpositionx+buttonsizex*4, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 4, 0);
  bnchdnbutton = new button(controlpanelpositionx+buttonsizex*5, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 5, 0);
  bnchupbutton = new button(controlpanelpositionx+buttonsizex*6, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 6, 0);
  blankbutton = new button(controlpanelpositionx+buttonsizex*7, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 0, 0);
  attachcoilbutton = new button(controlpanelpositionx+buttonsizex*8, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 7, 0);
  cleareverythingbutton = new button(controlpanelpositionx+buttonsizex*11, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 12, 0);
  addrungbutton = new button(controlpanelpositionx+buttonsizex*9, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 13, 0);
  removerungbutton = new button(controlpanelpositionx+buttonsizex*10, controlpanelpositiony, controlpanelsizex/12, controlpanelsizey/2, 14, 0);
  attachinputbutton = new button(controlpanelpositionx+buttonsizex*9, controlpanelpositiony+controlpanelsizey/2, controlpanelsizex/12, controlpanelsizey/2, 9, 0);
  detachinputbutton = new button(controlpanelpositionx+buttonsizex*10, controlpanelpositiony+controlpanelsizey/2, controlpanelsizex/12, controlpanelsizey/2, 10, 0);
  detachallinputbutton = new button(controlpanelpositionx+buttonsizex*11, controlpanelpositiony+controlpanelsizey/2, controlpanelsizex/12, controlpanelsizey/2, 11, 0);
  for (int i = 0; i < 8; i++) {
    inputbuttons.add( new button(controlpanelpositionx+buttonsizex*i+buttonsizex, controlpanelpositiony+controlpanelsizey/2, controlpanelsizex/12, controlpanelsizey/2, 8, i));
  }
  //INITIALIZE--------------------------------------------------------
  rungs.add(new rung(0));
  visiblerungs.add(rungs.get(0));
  deb = new debug(false);
}

void draw() {
  background(200);
  //scale(width/w, height/h);
  fill(0);
  //UPDATE INFORMATION------------------------------------------------
  for (int i = 0; i < rungs.size(); i++) {
    rung temprung = rungs.get(i);
    for (int j = 0; j < temprung.elements.size(); j++) {
      element tempelem = temprung.elements.get(j);
      tempelem.nodeCheck();
    }
  }
  getSelected();
  getInputs();
  deb.debugUpdate();  
  //DRAW WINDOW-------------------------------------------------------
  fill(0);
  stroke(0);
  strokeWeight(1);
  strokeCap(SQUARE);
  //DRAW TABLE--------------------------------------------------------
  fill(0);
  stroke(255);
  rect(tableborderpositionx, tableborderpositiony, tablebordersizex, tablebordersizey);
  strokeWeight(1);
  fill(255);
  line(tablepositionx-3, tablepositiony, tablepositionx-3, tablepositiony+tablesizey-40);
  line(tablepositionx+elementsize*maxelements+3, tablepositiony, tablepositionx+elementsize*maxelements+3, tablepositiony+tablesizey-40);

  for (int i = 0; i < visiblerungs.size(); i++) {
    rung temprung = visiblerungs.get(i);
    for (int j = 0; j < temprung.elements.size(); j++) {
      element tempelement = temprung.elements.get(j);
      tempelement.drawElement();
    }
  }
  drawVisibleRungs();

  //DRAW CONTROL PANEL------------------------------------------------
  strokeWeight(1);
  fill(0);
  rect(controlpanelpositionx, controlpanelpositiony, controlpanelsizex, controlpanelsizey);
  //DRAW COIL INFO PANEL----------------------------------------------
  fill(0);
  stroke(0, 255, 0);
  rect(coilinfopanelpositionx, coilinfopanelpositiony, coilinfopanelsizex, coilinfopanelsizey);
  drawCoilInfoPanel();
  //DRAW INPUT INFO PANEL----------------------------------------------
  drawInputInfoPanel();
  //DRAW BUTTONS-------------------------------------------------------
  wirebutton.drawButton();
  nocbutton.drawButton();
  nccbutton.drawButton();
  coilbutton.drawButton();
  bnchdnbutton.drawButton();
  bnchupbutton.drawButton();
  blankbutton.drawButton();
  attachcoilbutton.drawButton();
  cleareverythingbutton.drawButton();
  addrungbutton.drawButton();
  removerungbutton.drawButton();
  attachinputbutton.drawButton();
  detachinputbutton.drawButton();
  detachallinputbutton.drawButton();
  scrollupbutton.drawButton();
  scrolldownbutton.drawButton();
  for (int i = 0; i < inputbuttons.size(); i++) {
    button tempbutton = inputbuttons.get(i);
    tempbutton.drawButton();
  }
  deb.debugDraw();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e > 0) {
    scrollDown();
  }
  if (e < 0) {
    scrollUp();
  }
}

void mousePressed() {
  for (int i = 0; i < visiblerungs.size(); i++) {
    rung temprung = visiblerungs.get(i);
    for (int j = 0; j < temprung.elements.size(); j++) {
      element tempelement = temprung.elements.get(j);
      if (tempelement.hasCursor()) {
        tempelement.selected = !tempelement.selected;
      }
    }
  }
  if (blankbutton.hasCursor()) {
    changeSelected(0);
  }
  if (wirebutton.hasCursor()) {
    changeSelected(1);
  }
  if (nocbutton.hasCursor()) {
    changeSelected(2);
  }
  if (nccbutton.hasCursor()) {
    changeSelected(3);
  }
  if (coilbutton.hasCursor()) {
    changeSelected(4);
  }
  if (bnchdnbutton.hasCursor()) {
    changeSelected(5);
  }
  if (bnchupbutton.hasCursor()) {
    changeSelected(6);
  }
  if (attachcoilbutton.hasCursor()) {
    attachSelected();
  }
  if (cleareverythingbutton.hasCursor()) {
    clearEverything();
  }
  if (addrungbutton.hasCursor()) {
    rungs.add( new rung(rungs.size()));
  }
  if (removerungbutton.hasCursor()) {
    removeRung();
  }
  if (scrollupbutton.hasCursor()) {
    scrollUp();
  }
  if (scrolldownbutton.hasCursor()) {
    scrollDown();
  }
  if (attachinputbutton.hasCursor()) {
    for (int i = 0; i < selectedelements.size(); i++) {
      element tempelem = selectedelements.get(i);
      for (int j = 0; j < inputstoggledon.size(); j++) {
        button tempinp = inputstoggledon.get(j);
        tempinp.attachElement(tempelem);
        tempinp.ison = false;
        tempelem.selected = false;
      }
    }
  }
  if (detachinputbutton.hasCursor()) {
    for (int i = 0; i < inputstoggledon.size(); i++) {
      button tempinp = inputstoggledon.get(i);
      for (int j = 0; j < selectedelements.size(); j++) {
        element tempselelem = selectedelements.get(j);
        for (int k = 0; k < tempinp.attachedelements.size(); k++) {
          element inpelem = tempinp.attachedelements.get(k);
          if (tempselelem == inpelem) {
            tempinp.detachElement(tempselelem);
            tempselelem.energized = false;
          }
        }
      }
      tempinp.ison = false;
      for (int j = 0; j < selectedelements.size(); j++) {
        element tempelem = selectedelements.get(j);
        tempelem.selected = false;
      }
    }
  }
  for (int i = 0; i < inputbuttons.size(); i++) {
    button tempbutton = inputbuttons.get(i);
    if (tempbutton.hasCursor()) {
      tempbutton.toggleAttachedElements();
    }
  }
  if (detachallinputbutton.hasCursor()) {
    for (int i = 0; i < inputbuttons.size(); i++) {
      button tempbutton = inputbuttons.get(i);
      if (tempbutton.ison) {
        tempbutton.detachAll();
        tempbutton.ison = false;
      }
    }
  }
}

void keyPressed() {
  /*
  if (key == ' ') {
   for (int i = 0; i < selectedelements.size(); i++) {
   element tempelem = selectedelements.get(i);
   tempelem.selected = false;
   }
   }
   */
   // NEED TO MAKE A TEXTBOX OBJECT THAT USES THIS FUNCTION
  if ((key == ENTER) || (key == RETURN )) {
    saved = typing;
    println(saved);
    typing = "";
  } else if (key == BACKSPACE) {
    strlngth = typing.length();
    typing = typing.substring(0, strlngth-1);
  } else {
    typing = typing+key;
  }
}

//FUNCTIONS-------------------------------------------------------------

void changeSelected(int type) {
  for (int i = 0; i < rungs.size(); i++) {
    rung temprung = rungs.get(i);
    for (int j = 0; j < temprung.elements.size(); j++) {
      element tempelement = temprung.elements.get(j);
      if (tempelement.selected) {
        tempelement.type = type;
        tempelement.energized = false;
        tempelement.selected = false;
        tempelement.detachAll();
      }
    }
  }
}

void getSelected() {
  selectedelements.clear();
  for (int i = 0; i < rungs.size(); i++) {
    rung temprung = rungs.get(i);
    for (int j = 0; j < temprung.elements.size(); j++) {
      element tempelem = temprung.elements.get(j);
      if (tempelem.selected) {
        selectedelements.add(tempelem);
      }
    }
  }
}

void getInputs() {
  inputstoggledon.clear();
  for (int i = 0; i < inputbuttons.size(); i++) {
    button tempbutton = inputbuttons.get(i);
    if (tempbutton.ison) {
      inputstoggledon.add(tempbutton);
    }
  }
}

void attachSelected() {
  for (int i = 0; i < selectedelements.size(); i++) {
    element tempelem = selectedelements.get(i);
    for (int j = 0; j < selectedelements.size(); j++) {
      if (i !=j) {
        tempelem.attachElement(selectedelements.get(j));
      }
    }
    tempelem.selected = false;
  }
}

void clearEverything() {
  rungs.clear();
  for (int i = 0; i < inputbuttons.size(); i++) {
    button tempbutton = inputbuttons.get(i);
    tempbutton.detachAll();
  }
  rungs.add(new rung(0));
}

void removeRung() {
  if (rungs.size() > 1) {
    for (int i = 0; i < rungs.size(); i++) {
      rung temprung = rungs.get(i);
      for (int j = 0; j < temprung.elements.size(); j++) {
        element tempelem = temprung.elements.get(j);
        if (tempelem.type == 4) {
          for (int k = 0; k < tempelem.attachedelements.size(); k++) {
            element tempattach = tempelem.attachedelements.get(k);
            if (tempattach.rungloc == rungs.size()-1) {
              tempelem.attachedelements.remove(k);
            }
          }
        }
      }
    }
    for (int i = 0; i < inputbuttons.size(); i++) {
      button tempbutton = inputbuttons.get(i);
      for (int j = 0; j < tempbutton.attachedelements.size(); j++) {
        element tempelem = tempbutton.attachedelements.get(j);
        if (tempelem.rungloc == rungs.size()-1) {
          tempbutton.attachedelements.remove(j);
        }
      }
    }
    rungs.remove(rungs.size()-1);
  } else {
    println("Last Rung");
  }
}

void scrollUp() {
  if (rungs.size() > 12) {
    if (visiblerungsindex > 0) {
      visiblerungsindex--;
    }
  }
}

void scrollDown() {
  if (rungs.size() > 12) {
    if (visiblerungsindex < rungs.size()-1) {
      visiblerungsindex++;
    }
  }
}

//DRAW FUNCTIONS----------------------------------------------------------------

void drawBlank(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
}

void drawWire(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  line(posx, posy+sizey/2, posx+sizex, posy+sizey/2);
}

void drawNOC(float posx, float posy, float sizex, float sizey, boolean energized, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  if (energized) {
    stroke(255, 0, 0);
  } else {
    stroke(255);
  }
  line(posx, posy+sizey/2, posx+sizex/3, posy+sizey/2);
  line(posx+(sizex/3)*2, posy+sizey/2, posx+sizex, posy+sizey/2);
  line(posx+sizex/3, posy+sizey/4, posx+sizex/3, posy+(sizey/4)*3);
  line(posx+(sizex/3)*2, posy+sizey/4, posx+(sizex/3)*2, posy+(sizey/4)*3);
}

void drawNCC(float posx, float posy, float sizex, float sizey, boolean energized, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  if (energized) {
    stroke(255, 0, 0);
  } else {
    stroke(255);
  }
  line(posx, posy+sizey/2, posx+sizex/3, posy+sizey/2);
  line(posx+(sizex/3)*2, posy+sizey/2, posx+sizex, posy+sizey/2);
  line(posx+sizex/3, posy+sizey/4, posx+sizex/3, posy+(sizey/4)*3);
  line(posx+(sizex/3)*2, posy+sizey/4, posx+(sizex/3)*2, posy+(sizey/4)*3);
  line(posx+sizex/4, posy+(sizey/4)*3, posx+(sizex/4)*3, posy+sizey/4);
}

void drawCoil(float posx, float posy, float sizex, float sizey, boolean energized, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  line(posx, posy+sizey/2, posx+sizex, posy+sizey/2);
  if (energized) {
    fill(255, 0, 0);
  } else {
    fill(0);
  }
  circle(posx+sizex/2, posy+sizey/2, sizex/2);
}

void drawBnchDn(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  line(posx, posy+sizey/2, posx+sizex, posy+sizey/2);
  line(posx+sizex/2, posy+sizey/2, posx+sizex/2, posy+sizey);
}

void drawBnchUp(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  line(posx, posy+sizey/2, posx+sizex, posy+sizey/2);
  line(posx+sizex/2, posy+sizey/2, posx+sizex/2, posy);
}

void drawAttachCoil(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  fill(255);
  triangle(posx, posy, posx+sizex/2, posy+sizey/2, posx, posy+sizey);
  triangle(posx+sizex, posy, posx+sizex/2, posy+sizey/2, posx+sizex, posy+sizey);
}

void drawInput(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border, int number) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(int(sizex/2));
  text("X"+str(number), posx+sizex/2, posy+sizey/2);
  rectMode(CORNER);
}

void drawInputAttach(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(int(sizex/2));
  text("X+", posx+sizex/2, posy+sizey/2);
}

void drawInputDetach(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  fill(255);
  textSize(int(sizex/2));
  textAlign(CENTER, CENTER);
  text("X-", posx+sizex/2, posy+sizey/2);
}

void drawInputDetachAll(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  fill(255);
  textSize(int(sizex/2));
  textAlign(CENTER, CENTER);
  text("XC", posx+sizex/2, posy+sizey/2);
}

void drawClearEverything(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  fill(255);
  textSize(int(sizex/2));
  textAlign(CENTER, CENTER);
  text("CE", posx+sizex/2, posy+sizey/2);
}

void drawAddRung(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  fill(255);
  line(posx+sizex/2, posy, posx+sizex/2, posy+sizey/2);
  line(posx, posy+sizey/2, posx+sizex, posy+sizey/2);
  triangle(posx+(sizex/3), posy+(sizey/3), posx+(sizex/3)*2, posy+(sizey/3), posx+sizex/2, posy+sizey/2);
}

void drawRemoveRung(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  fill(255);
  line(posx, posy+sizey/2, posx+sizex, posy+sizey/2);
  line(posx+(sizex/4), posy+(sizey/4), posx+(sizex/4)*3, posy+(sizey/4)*3);
  line(posx+(sizex/4)*3, posy+(sizey/4), posx+(sizex/4), posy+(sizey/4)*3);
}

void drawScrollUp(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  fill(255);
  triangle(posx+(sizex/4), posy+sizey/2, posx+(sizex/4)*3, posy+sizey/2, posx+sizex/2, posy);
  rect(posx+sizex/3, posy+sizey/2, sizex/3, sizey/2);
}

void drawScrollDown(float posx, float posy, float sizex, float sizey, color fillcolor, boolean border) {
  fill(fillcolor);
  if (border) {
    stroke(255);
  } else {
    stroke(0);
  }
  rect(posx, posy, sizex, sizey);
  stroke(255);
  fill(255);
  triangle(posx+(sizex/4), posy+sizey/2, posx+(sizex/4)*3, posy+sizey/2, posx+sizex/2, posy+sizey);
  rect(posx+sizex/3, posy, sizex/3, sizey/2);
}

void drawCoilInfoPanel() {
  int numeric = 0;
  for (int i = 0; i < selectedelements.size(); i++) {
    element tempelem = selectedelements.get(i);
    if (tempelem.type == 4) {
      fill(0, 255, 0);
      textSize((height/175)*3);
      textAlign(LEFT, CENTER);
      text("Coil " +str(tempelem.rungloc)+":"+str(tempelem.elementpos)+" is attached to:", coilinfopanelpositionx+boundaryspace, 12+coilinfopanelpositiony+50*numeric);
      for (int j = 0; j < tempelem.attachedelements.size(); j++) {
        element tempattach = tempelem.attachedelements.get(j);
        if (j < 4) {
          text(str(tempattach.rungloc)+":"+str(tempattach.elementpos), boundaryspace+coilinfopanelpositionx+40*j, 12+coilinfopanelpositiony+10+50*numeric);
        }
        if ((j > 3) && (j < 8)) {
          text(str(tempattach.rungloc)+":"+str(tempattach.elementpos), boundaryspace+coilinfopanelpositionx+40*j-160, 12+coilinfopanelpositiony+20+50*numeric);
        }
        if ((j > 7) && (j < 12)) {
          text(str(tempattach.rungloc)+":"+str(tempattach.elementpos), boundaryspace+coilinfopanelpositionx+40*j-320, 12+coilinfopanelpositiony+30+50*numeric);
        }
      }
      numeric++;
    }
  }
}

void drawInputInfoPanel() {
  stroke(200, 200, 255);
  fill(0);
  textSize((height/175)*3);//12
  textAlign(LEFT, CENTER);
  rect(inputpanelpositionx, inputpanelpositiony, inputpanelsizex, inputpanelsizey);
  fill(200, 200, 255);
  for (int i = 0; i < inputbuttons.size(); i++) {
    button tempbutton = inputbuttons.get(i);
    fill(200, 200, 255);
    text("X"+str(i)+": ", inputpanelpositionx+boundaryspace, 12+inputpanelpositiony+(inputpanelsizey/8)*i);
    if (tempbutton.ison) {
      fill(255, 0, 0);
    } else {
      fill(200, 200, 255);
    }
    //text(str(tempbutton.ison), inputpanelpositionx+20,12+inputpanelpositiony+(inputpanelsizey/8)*i);
    for (int j = 0; j < tempbutton.attachedelements.size(); j++) {
      element tempelem = tempbutton.attachedelements.get(j);
      if (j < 3) {
        text(str(tempelem.rungloc)+":"+str(tempelem.elementpos), boundaryspace+inputpanelpositionx+40*j, inputpanelpositiony + ((inputpanelsizey/8)*i)+24);
      }
      if ((j > 2) && (j < 6)) {
        text(str(tempelem.rungloc)+":"+str(tempelem.elementpos), boundaryspace+inputpanelpositionx+40*j-120, inputpanelpositiony + ((inputpanelsizey/8)*i)+36);
      }
      if ((j > 5) && (j < 9)) {
        text(str(tempelem.rungloc)+":"+str(tempelem.elementpos), boundaryspace+inputpanelpositionx+40*j-240, inputpanelpositiony + ((inputpanelsizey/8)*i)+48);
      }
    }
  }
}

void drawVisibleRungs() {
  visiblerungs.clear();
  visiblerungsmaxindex = visiblerungsindex+maxvisiblerungs;

  if (rungs.size() < visiblerungsmaxindex) {
    for (int i = visiblerungsindex; i < rungs.size(); i++) {
      visiblerungs.add(rungs.get(i));
    }
  } else {
    for (int i = visiblerungsindex; i < visiblerungsmaxindex; i++) {
      visiblerungs.add(rungs.get(i));
    }
  }

  for (int i = 0; i < visiblerungs.size(); i++) {
    rung temprung = visiblerungs.get(i);
    temprung.updateDrawLocation(i);
    temprung.drawRung();
  }
}
