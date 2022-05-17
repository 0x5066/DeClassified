#include "..\..\..\lib/std.mi"
#include "..\scripts\IsWACUP.m"

Global group frameGroup;
Global Text IsWACUP;

System.onScriptLoaded(){

    initDetector();
    frameGroup = getScriptGroup();

    IsWACUP = frameGroup.findObject("isthiswacup");

    if(IsWACUP != 0){
        IsWACUP.setText("Is this WACUP?: Yes");
    }else{
        IsWACUP.setText("Is this WACUP?: No");
    }
}