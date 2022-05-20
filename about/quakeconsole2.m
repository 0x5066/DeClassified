#include "..\..\..\lib/std.mi"

Global GuiObject vuleft, vuright;
Global timer Countdown, VUtext;
Global String VULtext, VURtext;

Global int i;

System.onScriptLoaded(){

    group thisgroup = getScriptGroup();

    vuleft = thisgroup.findObject("VUL");
    vuright = thisgroup.findObject("VUR");

    Countdown = new Timer;
    Countdown.setDelay(2000);
    Countdown.start();

    VUtext = new Timer;
    VUtext.setDelay(0);
    VUtext.start();

    i = 0;
    vuleft.setTargetSpeed(1);
    vuright.setTargetSpeed(1);
}

Countdown.onTimer(){
    i++;

    if(i == 3){
        vuleft.setTargetA(255);
        vuleft.goToTarget();
        vuright.setTargetA(255);
        vuright.goToTarget();
    }
}

VUtext.onTimer(){

    if(getLeftVuMeter() < 100){
        VULtext = "0"+integerToString(getLeftVuMeter());
    }if(getLeftVuMeter() < 10){
        VULtext = "00"+integerToString(getLeftVuMeter());
    }else if(getLeftVuMeter() > 100){
        VULtext = integerToString(getLeftVuMeter());
    }

    if(getRightVuMeter() < 100){
        VURtext = "0"+integerToString(getRightVuMeter());
    }if(getRightVuMeter() < 10){
        VURtext = "00"+integerToString(getRightVuMeter());
    }else if(getRightVuMeter() > 100){
        VURtext = integerToString(getRightVuMeter());
    }

    vuleft.setXmlParam("text", "VU Left : "+VULtext);
    vuright.setXmlParam("text", "VU Right: "+VURtext);
}