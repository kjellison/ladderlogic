float tablepositionx;
float tablepositiony;
float tablesizex;
float tablesizey;
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
float elementsize;
int maxrungs = 12;
int maxelements = 20;

ArrayList<rung> rungs = new ArrayList<rung>();
ArrayList<button> inputbuttons = new ArrayList<button>();
ArrayList<element> selectedelements = new ArrayList<element>();
ArrayList<button> inputstoggledon = new ArrayList<button>();
button wirebutton, nocbutton, nccbutton, coilbutton, bnchdnbutton, bnchupbutton, blankbutton, attachcoilbutton, attachinputbutton, detachinputbutton, detachallinputbutton;
debug deb;

void setup() {
  size(1050, 700);
  //fullScreen();
  tablesizex = (width/3)*2;
  tablesizey = (height/3)*2-borderwidth;
  tablepositionx = (width/2)-(tablesizex/2);
  tablepositiony = borderwidth;
  elementsize = tablesizex/20;

  controlpanelsizey = (height-tablesizey-borderwidth*2-spacer);
  controlpanelsizex = ((controlpanelsizey/2)*11);
  controlpanelpositionx = width/2-controlpanelsizex/2;
  controlpanelpositiony = borderwidth+tablesizey+spacer;
  coilinfopanelpositionx = tablepositionx+tablesizex+5;
  coilinfopanelpositiony = 5;
  coilinfopanelsizex = (width-tablesizex)/2-10;
  coilinfopanelsizey = height-controlpanelsizey-60;
  inputpanelpositionx = 5;
  inputpanelpositiony = 5;
  inputpanelsizex = (width-tablesizex)/2-40;
  inputpanelsizey = height-controlpanelsizey-60;
  for (int i = 0; i < maxrungs; i++) {
    rungs.add(new rung(i));
  }
  wirebutton = new button(controlpanelpositionx, controlpanelpositiony, controlpanelsizey/2, controlpanelsizey/2, 1, 0);
  nocbutton = new button(controlpanelpositionx+controlpanelsizey/2, controlpanelpositiony, controlpanelsizey/2, controlpanelsizey/2, 2, 0);
  nccbutton = new button(controlpanelpositionx+(controlpanelsizey/2)*2, controlpanelpositiony, controlpanelsizey/2, controlpanelsizey/2, 3, 0);
  coilbutton = new button(controlpanelpositionx+(controlpanelsizey/2)*3, controlpanelpositiony, controlpanelsizey/2, controlpanelsizey/2, 4, 0);
  bnchdnbutton = new button(controlpanelpositionx+(controlpanelsizey/2)*4, controlpanelpositiony, controlpanelsizey/2, controlpanelsizey/2, 5, 0);
  bnchupbutton = new button(controlpanelpositionx+(controlpanelsizey/2)*5, controlpanelpositiony, controlpanelsizey/2, controlpanelsizey/2, 6, 0);
  blankbutton = new button(controlpanelpositionx+(controlpanelsizey/2)*6, controlpanelpositiony, controlpanelsizey/2, controlpanelsizey/2, 0, 0);
  attachcoilbutton = new button(controlpanelpositionx+(controlpanelsizey/2)*7, controlpanelpositiony, controlpanelsizey/2, controlpanelsizey/2, 7, 0);
  attachinputbutton = new button(controlpanelpositionx+(controlpanelsizey/2)*8, controlpanelpositiony+controlpanelsizey/2, controlpanelsizey/2, controlpanelsizey/2, 9, 0);
  detachinputbutton = new button(controlpanelpositionx+(controlpanelsizey/2)*9, controlpanelpositiony+controlpanelsizey/2, controlpanelsizey/2, controlpanelsizey/2, 10, 0);
  detachallinputbutton = new button(controlpanelpositionx+(controlpanelsizey/2)*10, controlpanelpositiony+controlpanelsizey/2, controlpanelsizey/2, controlpanelsizey/2, 11, 0);
  for (int i = 0; i < 8; i++) {
    inputbuttons.add( new button((controlpanelpositionx+(controlpanelsizey/2)*i), controlpanelpositiony+controlpanelsizey/2, controlpanelsizey/2, controlpanelsizey/2, 8, i));
  }
  deb = new debug(false);
}


void draw() {
  fill(0);
  stroke(0);
  strokeWeight(1);
  strokeCap(SQUARE);
  rect(0, 0, width, height);
  stroke(255);
  strokeWeight(5);
  line(tablepositionx, tablepositiony, tablepositionx, tablepositiony+tablesizey);
  line(tablepositionx+tablesizex, tablepositiony, tablepositionx+tablesizex, tablepositiony+tablesizey);
  strokeWeight(1);
  rect(controlpanelpositionx, controlpanelpositiony, controlpanelsizex, controlpanelsizey);
  stroke(0, 255, 0);
  rect(coilinfopanelpositionx, coilinfopanelpositiony, coilinfopanelsizex, coilinfopanelsizey);
  stroke(255);
  for (int i = 0; i < rungs.size(); i++) {
    rung temprung = rungs.get(i);
    temprung.drawRung();
  }

  for (int i = 0; i < rungs.size(); i++) {
    rung temprung = rungs.get(i);
    for (int j = 0; j < temprung.elements.size(); j++) {
      element tempelement = temprung.elements.get(j);
      tempelement.drawElement();
    }
  }
  wirebutton.drawButton();
  nocbutton.drawButton();
  nccbutton.drawButton();
  coilbutton.drawButton();
  bnchdnbutton.drawButton();
  bnchupbutton.drawButton();
  blankbutton.drawButton();
  attachcoilbutton.drawButton();
  attachinputbutton.drawButton();
  detachinputbutton.drawButton();
  detachallinputbutton.drawButton();
  for (int i = 0; i < inputbuttons.size(); i++) {
    button tempbutton = inputbuttons.get(i);
    tempbutton.drawButton();
  }
  getSelected();
  getInputs();
  coilInfoDraw();
  inputInfoDraw();
  deb.debugUpdate();
  deb.debugDraw();
}

void mousePressed() {
  for (int i = 0; i < rungs.size(); i++) {
    rung temprung = rungs.get(i);
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
  if (key == ' ') {
    for (int i = 0; i < selectedelements.size(); i++) {
      element tempelem = selectedelements.get(i);
      tempelem.selected = false;
    }
  }
}

void changeSelected(int type) {
  for (int i = 0; i < rungs.size(); i++) {
    rung temprung = rungs.get(i);
    for (int j = 0; j < temprung.elements.size(); j++) {
      element tempelement = temprung.elements.get(j);
      if (tempelement.selected) {
        tempelement.type = type;
        tempelement.selected = false;
        tempelement.detachAll();
      }
    }
  }
}

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
  textSize(int(sizey/2));
  text("X"+str(number), posx+sizex/4, posy+(sizey/3)*2);
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
  textSize(int(sizey/2));
  text("X+", posx+sizex/4, posy+(sizey/3)*2);
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
  textSize(int(sizey/2));
  text("X-", posx+sizex/4, posy+(sizey/3)*2);
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
  textSize(int(sizey/2));
  text("XC", posx+sizex/4, posy+(sizey/3)*2);
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

void coilInfoDraw() {
  int numeric = 0;
  for (int i = 0; i < selectedelements.size(); i++) {
    element tempelem = selectedelements.get(i);
    if (tempelem.type == 4) {
      
      fill(0, 255, 0);
      textSize(12);
      text("Coil " +str(tempelem.rungloc)+":"+str(tempelem.elementpos)+" is attached to:", coilinfopanelpositionx, 12+coilinfopanelpositiony+50*numeric);
      for (int j = 0; j < tempelem.attachedelements.size(); j++) {
        element tempattach = tempelem.attachedelements.get(j);
        if (j < 4) {
          text(str(tempattach.rungloc)+":"+str(tempattach.elementpos), coilinfopanelpositionx+40*j, 12+coilinfopanelpositiony+10+50*numeric);
        }
        if ((j > 3) && (j < 8)) {
          text(str(tempattach.rungloc)+":"+str(tempattach.elementpos), coilinfopanelpositionx+40*j-160, 12+coilinfopanelpositiony+20+50*numeric);
        }
        if ((j > 7) && (j < 12)) {
          text(str(tempattach.rungloc)+":"+str(tempattach.elementpos), coilinfopanelpositionx+40*j-320, 12+coilinfopanelpositiony+30+50*numeric);
        }
      }
      numeric++;
    }
  }
}

void inputInfoDraw() {
  stroke(0, 0, 255);
  fill(0);
  textSize(12);
  rect(inputpanelpositionx, inputpanelpositiony, inputpanelsizex, inputpanelsizey);
  fill(0, 0, 255);
  for (int i = 0; i < inputbuttons.size(); i++) {
    button tempbutton = inputbuttons.get(i);
    fill(0, 0, 255);
    text("X"+str(i)+": ", inputpanelpositionx, 12+inputpanelpositiony+(inputpanelsizey/8)*i);
    if (tempbutton.ison) {
      fill(255, 0, 0);
    } else {
      fill(0, 0, 255);
    }
    //text(str(tempbutton.ison), inputpanelpositionx+20,12+inputpanelpositiony+(inputpanelsizey/8)*i);
    for (int j = 0; j < tempbutton.attachedelements.size(); j++) {
      element tempelem = tempbutton.attachedelements.get(j);
      if (j < 3) {
        text(str(tempelem.rungloc)+":"+str(tempelem.elementpos), inputpanelpositionx+40*j, inputpanelpositiony + ((inputpanelsizey/8)*i)+24);
      }
      if ((j > 2) && (j < 6)) {
        text(str(tempelem.rungloc)+":"+str(tempelem.elementpos), inputpanelpositionx+40*j-120, inputpanelpositiony + ((inputpanelsizey/8)*i)+36);
      }
      if ((j > 5) && (j < 9)) {
        text(str(tempelem.rungloc)+":"+str(tempelem.elementpos), inputpanelpositionx+40*j-240, inputpanelpositiony + ((inputpanelsizey/8)*i)+48);
      }
    }
  }
}
