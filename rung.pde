class rung {
  float rungpositionx = tablepositionx;
  float rungpositiony;
  int rungid;
  ArrayList<element> elements = new ArrayList<element>();
  int rungpos;
  
  rung(int irungid) {
    rungid = irungid;
    rungpositiony = tablepositiony+elementsize*rungpos;
    for (int i = 0; i < maxelements; i++) {
      elements.add( new element((rungid*maxelements)+i, rungid,i, i));
    }
  }
  
  void updateDrawLocation(int irungpos) {
    rungpos = irungpos;
    rungpositiony = tablepositiony+elementsize*rungpos;
    for (int i = 0; i < elements.size(); i++) {
      element tempelem = elements.get(i);
      tempelem.rungdraw = rungpos;
    }
  }
  
  void drawRung() {
    fill(255);
    textSize((height/175)*3-4);
    textAlign(LEFT, CENTER);
    text(str(rungid), rungpositionx-20, rungpositiony+elementsize/2);
    if (rungpos == 0) {
      for (int i = 0; i < elements.size(); i++) {
        
        text(str(i), tablepositionx+i*elementsize+elementsize/2-5, tablepositiony-10);
      }
    }
  }
}
