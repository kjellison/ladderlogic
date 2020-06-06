class debug {

  boolean enabled;
  ArrayList<element> selectedelements = new ArrayList<element>();
  float debugposx = 10;
  float debugposy = 10;
  float debugsizex = 120;
  float debugsizey = 400;

  debug(boolean ienabled) {
    enabled = ienabled;
  }

  void debugUpdate() {
    selectedelements.clear();
    for (int i = 0; i < rungs.size(); i++) {
      rung temprung = rungs.get(i);
      for (int j = 0; j < temprung.elements.size(); j++) {
        element tempelement = temprung.elements.get(j);
        if (tempelement.selected) {
          selectedelements.add(tempelement);
        }
      }
    }
  }

  void debugDraw() {
    if (enabled) {
      stroke(255, 0, 0);
      fill(0);
      rect(debugposx, debugposy, debugsizex, debugsizey);
      fill(255,0,0);
      textSize(10);
      for (int i = 0; i < selectedelements.size(); i++) {
        element tempelem = selectedelements.get(i);
        text("Engzd: " + str(tempelem.energized), debugposx+5, debugposy+10+ i*80);
        text("Top: " + str(tempelem.topnode), debugposx+5, debugposy+20+ i*80);
        text("Bot: " + str(tempelem.bottomnode), debugposx+5, debugposy+30+ i*80);
        text("Left: " + str(tempelem.leftnode), debugposx+5, debugposy+40+ i*80);
        text("Right: " + str(tempelem.rightnode), debugposx+5, debugposy+50+ i*80);
        text("HasPre: " + str(tempelem.haspreviouselement), debugposx+5, debugposy+60+ i*80);
      }
    }
  }
}
