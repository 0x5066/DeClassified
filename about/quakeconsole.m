#include "..\..\..\lib/std.mi"

Global GuiObject QuakeConsole;
Global timer Countdown;

Global int i;

System.onScriptLoaded(){

    group thisgroup = getScriptGroup();

    QuakeConsole = thisgroup.findObject("cooldebuginfo");

    Countdown = new Timer;
    Countdown.setDelay(2000);
    Countdown.start();

    i = 0;
    QuakeConsole.setTargetSpeed(1.5);
    QuakeConsole.setTargetA(255);
    QuakeConsole.goToTarget();
}

Countdown.onTimer(){
    i++;

    if(i == 2){
        QuakeConsole.setTargetY(0);
        QuakeConsole.goToTarget();
    }
}