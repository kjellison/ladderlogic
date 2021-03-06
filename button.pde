class button {
  float positionx;
  float positiony;
  float sizex;
  float sizey;
  int type;
  int num;
  color idlecolor = color(0);
  color hovercolor = color(100);
  color selectedcolor = color(0, 100, 0);
  color selectedhovercolor = color(0, 200, 0);
  color fillcolor;
  boolean ison;
  ArrayList<element> attachedelements = new ArrayList<element>();
  String buttontext;
  String inputlabel = "";

  button(float ipositionx, float ipositiony, float isizex, float isizey, int itype, int inum) {
    positionx = ipositionx;
    positiony = ipositiony;
    sizex = isizex;
    sizey = isizey;
    type = itype;
    num = inum;
  }
  void textVar(String ibuttontext) {
    buttontext = ibuttontext;
  }
  
  void drawButton() {
    if (ison) {
      if (hasCursor()) {
        fillcolor = selectedhovercolor;
      } else {
        fillcolor = selectedcolor;
      }
    } else {
      if (hasCursor()) {
        fillcolor = hovercolor;
      } else {
        fillcolor = idlecolor;
      }
    }

    switch (type) {
      case 0: 
        drawBlank(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 1: 
        drawWire(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 2: 
        drawNOC(positionx, positiony, sizex, sizey, false, fillcolor, true);
        break;
      case 3: 
        drawNCC(positionx, positiony, sizex, sizey, false, fillcolor, true);
        break;
      case 4: 
        drawCoil(positionx, positiony, sizex, sizey, false, fillcolor, true);
        break;
      case 5: 
        drawBnchDn(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 6: 
        drawBnchUp(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 7: 
        drawAttachCoil(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 8: 
        drawInput(positionx, positiony, sizex, sizey, fillcolor, true, num, inputlabel);
        break;
      case 9: 
        drawInputAttach(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 10: 
        drawInputDetach(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 11: 
        drawInputDetachAll(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 12: 
        drawClearEverything(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 13: 
        drawAddRung(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 14: 
        drawRemoveRung(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 15: 
        drawScrollUp(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 16: 
        drawScrollDown(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 17:
        drawTextButton(positionx, positiony, sizex, sizey, fillcolor, true, buttontext);
        break;
      case 18:
        drawCross(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
      case 19:
        drawVert(positionx, positiony, sizex, sizey, fillcolor, true);
        break;
    }
  }
  
  void attachElement(element ielem) {
    attachedelements.add(ielem);
    ielem.label = inputlabel;
  }
  
  void detachElement(element ielem) {
    for (int i = 0; i < attachedelements.size(); i++) {
      element tempelem = attachedelements.get(i);
      if (tempelem.elementid == ielem.elementid) {
        attachedelements.remove(i);
      }
    }
  }

  void detachAll() {
    removeInputLabel();
    attachedelements.clear();
  }
  
  void toggleAttachedElements() {
    ison = !ison;
    for (int i = 0; i < attachedelements.size(); i++) {
      element tempelem = attachedelements.get(i);
      tempelem.energized = ison;
    }
  }
  
  void addInputLabel(String ilabel) {
    if (type == 8) {
      inputlabel = ilabel;
      for (int i = 0; i < attachedelements.size(); i++) {
        element tempelem = attachedelements.get(i);
        tempelem.label = inputlabel;
      }
    } else {
      println("Tried to add a label to a input button");
    }
  }
  
  void removeInputLabel() {
    inputlabel = "";
    for (int i = 0; i < attachedelements.size(); i++) {
        element tempelem = attachedelements.get(i);
        tempelem.label = inputlabel;
    }
  }

  boolean hasCursor() {
    if ((mouseX > positionx) && (mouseX < positionx+sizex) &&
      (mouseY > positiony) && (mouseY < positiony+sizey)) {
      return true;
    } else {
      return false;
    }
  }
}
