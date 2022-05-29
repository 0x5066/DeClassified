#include "..\..\..\lib/std.mi"
#include "..\scripts\IsWACUP.m"

Global group frameGroup;
Global Text WACUPtxt;

Function DetectWACUP();

System.onScriptLoaded(){

    initDetector();
    frameGroup = getScriptGroup();

    WACUPtxt = frameGroup.findObject("isthiswacup");


    if(IsWACUP == 1){
        WACUPtxt.setText("Is this WACUP?: Yes");
    }else if(IsWACUP == 0){
        WACUPtxt.setText("Is this WACUP?: No");
    }
}