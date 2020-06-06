class rung {
  float rungpositionx = tablepositionx;
  float rungpositiony;
  int rungid;
  ArrayList<element> elements = new ArrayList<element>();
  
  rung(int irungid) {
    rungid = irungid;
    rungpositiony = tablepositiony+elementsize*rungid;
    for (int i = 0; i < maxelements; i++) {
      elements.add( new element((rungid*20)+i, rungid,i));
    }
  }
  
  void drawRung() {
    fill(255);
    //line(tablepositionx, tablepositiony+(rungid*elementsize), tablepositionx+tablesizex, tablepositiony+(rungid*elementsize));
    textSize(12);
    text(str(rungid), rungpositionx-20, rungpositiony+elementsize/2);
    if (rungid ==0) {
      for (int i =0; i < elements.size(); i++) {
        
        text(str(i), tablepositionx+i*elementsize+elementsize/2, tablepositiony-10);
      }
    }
  }
}
