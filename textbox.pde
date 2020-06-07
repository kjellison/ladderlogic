class textbox {
  float positionx;
  float positiony;
  float sizex;
  float sizey;
  String buttontext;
  String typedtext = "";
  String savedtext = "" ;
  boolean coilselected = false;
  boolean isactive = false;
  button labelbutton;

  textbox(float ipositionx, float ipositiony, float isizex, float isizey, String ibuttontext) {
    positionx = ipositionx;
    positiony = ipositiony;
    sizex = isizex;
    sizey = isizey;
    buttontext = ibuttontext;
    labelbutton = new button(positionx+20, positiony+sizey/4, sizex/12, sizey/2, 17, 0);
    labelbutton.textVar(buttontext);
  }

  void typedLetter(String ityped) {
    typedtext = typedtext+ityped;
  }

  void backSpace() {
    int stringlength = typedtext.length();
    typedtext = typedtext.substring(0, stringlength-1);
  }

  String stringReturn() {
    savedtext = typedtext;
    typedtext = "";
    return savedtext;
  }

  void drawTextBox() {
    fill(0);
    stroke(255);
    rect(positionx, positiony, sizex, sizey);
    if (coilselected) {
      labelbutton.drawButton();
      if (isactive) {
        stroke(200, 0, 0);
        fill(255);
        rect(positionx+40+sizex/12, positiony+sizey/4, sizex/3, sizey/2);
        fill(0);
        text(typedtext, positionx+40+sizex/12, positiony+sizey/4, sizex/3, sizey/2);
      }
    }
  }
}
