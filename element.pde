class element {

  int elementid;
  int rungloc;
  int elementpos;
  float positionx;
  float positiony;
  int type = 1;
  boolean topnode, bottomnode, rightnode, leftnode;
  boolean energized = false;
  boolean selected = false;
  boolean hasnextelement, haspreviouselement, hasaboveelement, hasbelowelement;
  boolean hasaboverung, hasbelowrung;
  color idlecolor = color(0);
  color hovercolor = color(100);
  color selectedcolor = color(0, 100, 0);
  color selectedhovercolor = color(0, 200, 0);
  color fillcolor;
  rung thisrung, aboverung, belowrung;
  element nextelement, previouselement, aboveelement, belowelement;
  ArrayList<element> attachedelements = new ArrayList<element>();
  int rungdraw;

  element(int ielementid, int irungloc, int ielementpos, int irungdraw) {
    elementid = ielementid;
    rungloc = irungloc;
    elementpos = ielementpos;
    rungdraw = irungdraw;
    positionx = tablepositionx + elementsize*elementpos;
    positiony = tablepositiony + elementsize*rungdraw;
  }

  void drawElement() {
    positiony = tablepositiony + elementsize*rungdraw;
    //nodeCheck();
    if (selected) {
      fillcolor = selectedcolor;
      if (hasCursor()) {
        fillcolor = selectedhovercolor;
      }
    } else if (hasCursor()) {
      fillcolor = hovercolor;
    } else {
      fillcolor = idlecolor;
    }
    switch (type) {
      case 0:
      drawBlank(positionx, positiony, elementsize, elementsize, fillcolor, false);
      break;
      case 1:
      drawWire(positionx, positiony, elementsize, elementsize, fillcolor, false);
      break;
      case 2:
      drawNOC(positionx, positiony, elementsize, elementsize, energized, fillcolor, false);
      break;
      case 3:
      drawNCC(positionx, positiony, elementsize, elementsize, energized, fillcolor, false);
      break;
      case 4:
      drawCoil(positionx, positiony, elementsize, elementsize, energized, fillcolor, false);
      break;
      case 5:
      drawBnchDn(positionx, positiony, elementsize, elementsize, fillcolor, false);
      break;
      case 6:
      drawBnchUp(positionx, positiony, elementsize, elementsize, fillcolor, false);
    }
    if ((type > 1) && (type < 5)) {
      fill(0,255,0);
      textSize((height/175)*3-4);
      textAlign(LEFT, CENTER);
      text(str(rungloc), positionx, positiony+10);
      text(str(elementpos), positionx+elementsize-((height/175)*3), positiony+10);
    }
  }

  void nodeCheck() {
    thisrung = rungs.get(rungloc);
    haspreviouselement = false;
    hasnextelement = false;
    hasaboveelement = false;
    hasbelowelement = false;


    for (int i = 0; i < thisrung.elements.size(); i++) {
      element tempelement = thisrung.elements.get(i);
      if (tempelement.elementpos == elementpos-1) {
        if (tempelement.type != 0) {
          haspreviouselement = true;
          previouselement = tempelement;
          break;
        } else {
          haspreviouselement = false;
        }
      }
    }
    for (int i = 0; i < thisrung.elements.size(); i++) {
      element tempelement = thisrung.elements.get(i);
      if (tempelement.elementpos == elementpos+1) {
        if (tempelement.type != 0) {
          hasnextelement = true;
          nextelement = tempelement;
          break;
        } else {
          hasnextelement = false;
        }
      }
    }

    if (rungloc > 0) {
      aboverung = rungs.get(rungloc-1);
      hasaboverung = true;
      for (int i = 0; i < aboverung.elements.size(); i++) {
        element tempelement = aboverung.elements.get(i);
        if (tempelement.elementpos == elementpos) {
          aboveelement = tempelement;
          hasaboveelement = true;
          break;
        } else {
          hasaboveelement = false;
        }
      }
    } else {
      hasaboverung = false;
    }

    if (rungloc < rungs.size()-1) {
      hasbelowrung = true;
      belowrung = rungs.get(rungloc+1);
      for (int i = 0; i < belowrung.elements.size(); i++) {
        element tempelement = belowrung.elements.get(i);
        if (tempelement.elementpos == elementpos) {
          hasbelowelement = true;
          belowelement = tempelement;
          break;
        } else {
          hasbelowelement = false;
        }
      }
    }
    
    if (!haspreviouselement) {
      leftnode = false;
    }

    switch(type) {
    case 0: //BLANK
      topnode = false;
      bottomnode = false;
      rightnode = false;
      leftnode = false;
      break;
    case 1: //WIRE
      topnode = false;
      bottomnode = false;
      if (elementpos == 0) {
        leftnode = true;
      }
      rightnode = leftnode;
      break;
    case 2: //NOC
      topnode = false;
      bottomnode = false;
      if (energized) {
        rightnode = leftnode;
      } else {
        rightnode = false;
      }
      break;
    case 3: //NCC
      topnode = false;
      bottomnode = false;
      if (energized) {
        rightnode = false;
      } else {
        rightnode = leftnode;
      }
      break;
    case 4: //COIL
      topnode = false;
      bottomnode = false;
      rightnode = leftnode;
      if (leftnode) {
        energized = true;
      } else {
        energized = false;
      }
      for (int i = 0; i < attachedelements.size(); i++) {
        element tempelem = attachedelements.get(i);
        if (energized) {
          tempelem.energized = true;
        } else {
          tempelem.energized = false;
        }
      }

      break;
    case 5: //BRANCHDOWN
      topnode = false;
      if (haspreviouselement) {
        rightnode = leftnode | bottomnode;
        bottomnode = leftnode;
        if (hasbelowelement) {
          if (belowelement.type == 6) {
            belowelement.topnode = leftnode | belowelement.leftnode;
          }
        }
      } else {
        rightnode = bottomnode;
        leftnode = false;
      }
      break;
    case 6: //BRANCHUP
      bottomnode = false;
      if (haspreviouselement) {
        rightnode = leftnode | topnode;
        topnode = leftnode;
        if (hasaboveelement) {
          if (aboveelement.type == 5) {
            aboveelement.bottomnode = leftnode | aboveelement.leftnode;
          }
        }
      } else {
        rightnode = topnode;
        leftnode = false;
      }
    }
    if (type != 0) {
      if (hasnextelement) {
        nextelement.leftnode = rightnode;
      }
    }
  }

  boolean hasCursor() {
    if ((mouseX > positionx) && (mouseX < positionx+elementsize) &&
      (mouseY > positiony) && (mouseY < positiony+elementsize)) {
      return true;
    } else {
      return false;
    }
  }

  void attachElement(element ielem) {
    attachedelements.add(ielem);
  }

  void detachElement(element ielem, boolean recurs) {
    for (int i = 0; i < attachedelements.size(); i++) {
      element tempelem = attachedelements.get(i);
      if (tempelem.elementid == ielem.elementid) {
        if (!recurs) {
        ielem.detachElement(this, true);
        attachedelements.remove(i);
        } else {
          tempelem.energized = false;
          attachedelements.remove(i);
        }
      }
    }
  }

  void detachAll() {
    for (int i = 0; i < attachedelements.size(); i++) {
      element tempelem = attachedelements.get(i);
      tempelem.detachElement(this, false);
    }
  }
}
