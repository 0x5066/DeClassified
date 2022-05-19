#include "..\..\..\lib/std.mi"

Global GuiObject blurrytext;
Global timer textblur;

Global int i;

System.onScriptLoaded(){

    group thisgroup = getScriptGroup();

    blurrytext = thisgroup.findObject("blurrytext");

    textblur = new Timer;
    textblur.setDelay(0);
    textblur.start();
    blurrytext.setXmlParam("alpha", integertostring((getLeftVuMeter()+getRightVuMeter())/2));
}

textblur.onTimer(){
    blurrytext.setXmlParam("alpha", integertostring((getLeftVuMeter()+getRightVuMeter())/2));
}