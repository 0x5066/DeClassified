//Handles switching most of the main windows,
//the Equalizer does this on it's own, though the
//mechanism is the same.

#include "..\..\..\lib/std.mi"
#include "IsWACUP.m"

Global GuiObject WAPLC;
Global Group frameGroup, frameGroupPL, frameGroupShade, frameGroupVideo, frameGroupMB;

Global Layer wacupmain, wacuptitlebar, wacupshade;
Global Layer wacuppl1, wacuppl2, wacuppl3, wacuppl4, wacuppl5, wacuppl6, wacuppl7, wacuppl8, wacuppl9, wacupplvis, wacupplcenter;
Global Layer wacupvideo1, wacupvideo2, wacupvideo3, wacupvideo4, wacupvideo5, wacupvideo6, wacupvideo7, wacupvideo8, wacupvideo9;
Global Layer wacupMB1, wacupMB2, wacupMB3, wacupMB4, wacupMB5, wacupMB6, wacupMB7, wacupMB8, wacupMB9;

System.onScriptLoaded(){

    initDetector();

    frameGroup = getContainer("Main").getLayout("Normal");
	frameGroupShade = getContainer("Main").getLayout("shade");
    frameGroupVideo = getContainer("video").getLayout("normal");
    frameGroupMB = getContainer("Minibrowser").getLayout("normal");
    frameGroupPL = getContainer("PL").getLayout("normal");

    wacupshade = frameGroupShade.findObject("washade");

    wacupmain = frameGroup.findObject("mainwnd");
	wacuptitlebar = frameGroup.findObject("wa.titlebar");

	wacuppl1 = frameGroupPL.findObject("wa2.pl1");
	wacuppl2 = frameGroupPL.findObject("wa2.pl2");
	wacuppl3 = frameGroupPL.findObject("wa2.pl3");
	wacuppl4 = frameGroupPL.findObject("wa2.pl4");
	wacuppl5 = frameGroupPL.findObject("wa2.pl5");
	wacuppl6 = frameGroupPL.findObject("wa2.pl6");
	wacuppl7 = frameGroupPL.findObject("wa2.pl7");
	wacuppl8 = frameGroupPL.findObject("wa2.pl8");
	wacuppl9 = frameGroupPL.findObject("wa2.pl9");
	wacupplcenter = frameGroupPL.findObject("pl.center.logo");
	wacupplvis = frameGroupPL.findObject("pl.vis.area");
	WAPLC = frameGroupPL.findObject("wasabi.list");

	wacupvideo1 = frameGroupVideo.findObject("video.topleft");
	wacupvideo2 = frameGroupVideo.findObject("video.stretchybit");
	wacupvideo3 = frameGroupVideo.findObject("video.center");
	wacupvideo4 = frameGroupVideo.findObject("video.topright");
	wacupvideo5 = frameGroupVideo.findObject("video.left");
	wacupvideo6 = frameGroupVideo.findObject("video.right");
	wacupvideo7 = frameGroupVideo.findObject("video.bottomleft");
	wacupvideo8 = frameGroupVideo.findObject("video.bottom.stretchybit");
	wacupvideo9 = frameGroupVideo.findObject("video.bottomright");

	wacupMB1 = frameGroupMB.findObject("minibrowser.topleft");
	wacupMB2 = frameGroupMB.findObject("minibrowser.stretchybit");
	wacupMB3 = frameGroupMB.findObject("minibrowser.center");
	wacupMB4 = frameGroupMB.findObject("minibrowser.topright");
	wacupMB5 = frameGroupMB.findObject("minibrowser.left");
	wacupMB6 = frameGroupMB.findObject("minibrowser.right");
	wacupMB7 = frameGroupMB.findObject("minibrowser.bottomleft");
	wacupMB8 = frameGroupMB.findObject("minibrowser.bottom.stretchybit");
	wacupMB9 = frameGroupMB.findObject("minibrowser.bottomright");

	if(IsWACUP != 0){
		wacupmain.setXmlParam("image", "wacup.main");
		wacuptitlebar.setXmlParam("image", "wacup.titlebar.on");
		wacuptitlebar.setXmlParam("inactiveimage", "wacup.titlebar.off");
		wacupshade.setXmlParam("image", "wacup.player.shade.enabled");
		wacupshade.setXmlParam("inactiveimage", "wacup.player.shade.disabled");
		wacuppl1.setXmlParam("image", "wacup.pl.1");
		wacuppl1.setXmlParam("inactiveimage", "wacup.pl.1.disabled");
		wacuppl2.setXmlParam("image", "wacup.pl.2");
		wacuppl2.setXmlParam("inactiveimage", "wacup.pl.2.disabled");
		wacuppl3.setXmlParam("image", "wacup.pl.3");
		wacuppl3.setXmlParam("inactiveimage", "wacup.pl.3.disabled");
		wacuppl4.setXmlParam("image", "wacup.pl.4");
		wacuppl6.setXmlParam("image", "wacup.pl.6");
		wacuppl7.setXmlParam("image", "wacup.pl.7");
		wacuppl8.setXmlParam("image", "wacup.pl.8");
		wacuppl9.setXmlParam("image", "wacup.pl.9");
		wacupplcenter.setXmlParam("image", "wacup.pl.2.center");
		wacupplcenter.setXmlParam("inactiveimage", "wacup.pl.2.center.disabled");
		wacupplvis.setXmlParam("image", "wacup.pl.8.vis");
		WAPLC.setXmlParam("x", "24");
		WAPLC.setXmlParam("w", "-62");
		wacupvideo1.setXmlParam("image", "wacup.video.topleft.active");
		wacupvideo1.setXmlParam("inactiveimage", "wacup.video.topleft.inactive");
		wacupvideo2.setXmlParam("image", "wacup.video.top.stretchybit.active");
		wacupvideo2.setXmlParam("inactiveimage", "wacup.video.top.stretchybit.inactive");
		wacupvideo3.setXmlParam("image", "wacup.video.top.center.active");
		wacupvideo3.setXmlParam("inactiveimage", "wacup.video.top.center.inactive");
		wacupvideo4.setXmlParam("image", "wacup.video.topright.active");
		wacupvideo4.setXmlParam("inactiveimage", "wacup.video.topright.inactive");
		wacupvideo5.setXmlParam("image", "wacup.video.left");
		wacupvideo6.setXmlParam("image", "wacup.video.right");
		wacupvideo7.setXmlParam("image", "wacup.video.bottomleft");
		wacupvideo8.setXmlParam("image", "wacup.video.bottom.stretchybit");
		wacupvideo9.setXmlParam("image", "wacup.video.bottomright");
		wacupMB1.setXmlParam("image", "wacup.browser.topleft.active");
		wacupMB2.setXmlParam("image", "wacup.browser.top.stretchybit.active");
		wacupMB3.setXmlParam("image", "wacup.browser.top.center.active");
		wacupMB4.setXmlParam("image", "wacup.browser.topright.active");
		wacupMB1.setXmlParam("inactiveimage", "wacup.browser.topleft.inactive");
		wacupMB2.setXmlParam("inactiveimage", "wacup.browser.top.stretchybit.inactive");
		wacupMB3.setXmlParam("inactiveimage", "wacup.browser.top.center.inactive");
		wacupMB4.setXmlParam("inactiveimage", "wacup.browser.topright.inactive");
		wacupMB5.setXmlParam("image", "wacup.browser.left");
		wacupMB6.setXmlParam("image", "wacup.browser.right");
		wacupMB7.setXmlParam("image", "wacup.browser.bottomleft");
		wacupMB8.setXmlParam("image", "wacup.browser.bottom.stretchybit");
		wacupMB9.setXmlParam("image", "wacup.browser.bottomright");
	}else{
		wacupmain.setXmlParam("image", "wa.main");
		wacuptitlebar.setXmlParam("image", "wa.titlebar.on");
		wacuptitlebar.setXmlParam("inactiveimage", "wa.titlebar.off");
		wacupshade.setXmlParam("image", "wa2.player.shade.enabled");
		wacupshade.setXmlParam("inactiveimage", "wa2.player.shade.disabled");
		wacuppl1.setXmlParam("image", "wa2.pl.1");
		wacuppl1.setXmlParam("inactiveimage", "wa2.pl.1.disabled");
		wacuppl2.setXmlParam("image", "wa2.pl.2");
		wacuppl2.setXmlParam("inactiveimage", "wa2.pl.2.disabled");
		wacuppl3.setXmlParam("image", "wa2.pl.3");
		wacuppl3.setXmlParam("inactiveimage", "wa2.pl.3.disabled");
		wacuppl4.setXmlParam("image", "wa2.pl.4");
		wacuppl6.setXmlParam("image", "wa2.pl.6");
		wacuppl7.setXmlParam("image", "wa2.pl.7");
		wacuppl8.setXmlParam("image", "wa2.pl.8");
		wacuppl9.setXmlParam("image", "wa2.pl.9");
		wacupplcenter.setXmlParam("image", "wa2.pl.2.center");
		wacupplcenter.setXmlParam("inactiveimage", "wa2.pl.2.center.disabled");
		wacupplvis.setXmlParam("image", "wa2.pl.8.vis");
		WAPLC.setXmlParam("x", "20");
		WAPLC.setXmlParam("w", "-34");
		wacupvideo1.setXmlParam("image", "video.topleft.active");
		wacupvideo1.setXmlParam("inactiveimage", "video.topleft.inactive");
		wacupvideo2.setXmlParam("image", "video.top.stretchybit.active");
		wacupvideo2.setXmlParam("inactiveimage", "video.top.stretchybit.inactive");
		wacupvideo3.setXmlParam("image", "video.top.center.active");
		wacupvideo3.setXmlParam("inactiveimage", "video.top.center.inactive");
		wacupvideo4.setXmlParam("image", "video.topright.active");
		wacupvideo4.setXmlParam("inactiveimage", "video.topright.inactive");
		wacupvideo5.setXmlParam("image", "video.left");
		wacupvideo6.setXmlParam("image", "video.right");
		wacupvideo7.setXmlParam("image", "video.bottomleft");
		wacupvideo8.setXmlParam("image", "video.bottom.stretchybit");
		wacupvideo9.setXmlParam("image", "video.bottomright");
		wacupMB1.setXmlParam("image", "mb.topleft.active");
		wacupMB2.setXmlParam("image", "mb.top.stretchybit.active");
		wacupMB3.setXmlParam("image", "mb.top.center.active");
		wacupMB4.setXmlParam("image", "mb.topright.active");
		wacupMB1.setXmlParam("inactiveimage", "mb.topleft.inactive");
		wacupMB2.setXmlParam("inactiveimage", "mb.top.stretchybit.inactive");
		wacupMB3.setXmlParam("inactiveimage", "mb.top.center.inactive");
		wacupMB4.setXmlParam("inactiveimage", "mb.topright.inactive");
		wacupMB5.setXmlParam("image", "mb.left");
		wacupMB6.setXmlParam("image", "mb.right");
		wacupMB7.setXmlParam("image", "mb.bottomleft");
		wacupMB8.setXmlParam("image", "mb.bottom.stretchybit");
		wacupMB9.setXmlParam("image", "mb.bottomright");
	}
}