//Handles switching most of the main windows,
//the Equalizer does this on it's own, though the
//mechanism is the same.

#include "compiler/lib/std.mi"
#include "IsWACUP.m"

Global Group frameGroup, frameGroupShade;

Global Layer wacupmain, wacuptitlebar, wacupshade;
Global Button AboutTooltip, SysTooltip, Sys2Tooltip;

System.onScriptLoaded(){

    initDetector();

    frameGroup = getContainer("Main").getLayout("Normal");
	frameGroupShade = getContainer("Main").getLayout("shade");

    wacupshade = frameGroupShade.findObject("washade");

    wacupmain = frameGroup.findObject("mainwnd");
	wacuptitlebar = frameGroup.findObject("wa.titlebar");
	AboutTooltip = frameGroup.findObject("AboutWinamp");
	SysTooltip = frameGroup.findObject("wa.sysmenu");
	Sys2Tooltip = frameGroupShade.findObject("sysbutton");

	if(IsWACUP != 0){
		wacupmain.setXmlParam("image", "wacup.main");
		wacuptitlebar.setXmlParam("image", "wacup.titlebar.on");
		wacuptitlebar.setXmlParam("inactiveimage", "wacup.titlebar.off");
		wacupshade.setXmlParam("image", "wacup.player.shade.enabled");
		wacupshade.setXmlParam("inactiveimage", "wacup.player.shade.disabled");
		AboutTooltip.setXmlParam("tooltip", "About WACUP");
		SysTooltip.setXmlParam("tooltip", "WACUP Menu");
		Sys2Tooltip.setXmlParam("tooltip", "WACUP Menu");
	}else{
		wacupmain.setXmlParam("image", "wa.main");
		wacuptitlebar.setXmlParam("image", "wa.titlebar.on");
		wacuptitlebar.setXmlParam("inactiveimage", "wa.titlebar.off");
		wacupshade.setXmlParam("image", "wa2.player.shade.enabled");
		wacupshade.setXmlParam("inactiveimage", "wa2.player.shade.disabled");
		AboutTooltip.setXmlParam("tooltip", "About Winamp");
		SysTooltip.setXmlParam("tooltip", "Winamp Menu");
		Sys2Tooltip.setXmlParam("tooltip", "Winamp Menu");
	}
}