#include "..\..\..\lib/std.mi"
#include "..\scripts\IsWACUP.m"

Global group frameGroup;
Global Text WACUPtxt;

Global layer wacupmain, wacuptitlebar;

Function DetectWACUP();

System.onScriptLoaded(){

    initDetector();
    frameGroup = getScriptGroup();

    WACUPtxt = frameGroup.findObject("isthiswacup");

    wacupmain = frameGroup.findObject("mainwnd");
	wacuptitlebar = frameGroup.findObject("wa.titlebar");

    if(IsWACUP == 1){
        WACUPtxt.setText("Is this WACUP?: Yes");
        wacupmain.setXmlParam("image", "wacup.main");
		wacuptitlebar.setXmlParam("image", "wacup.titlebar.on");
		wacuptitlebar.setXmlParam("inactiveimage", "wacup.titlebar.off");
    }else if(IsWACUP == 0){
        WACUPtxt.setText("Is this WACUP?: No");
        wacupmain.setXmlParam("image", "wa.main");
		wacuptitlebar.setXmlParam("image", "wa.titlebar.on");
		wacuptitlebar.setXmlParam("inactiveimage", "wa.titlebar.off");
    }
}