/*---------------------------------------------------
-----------------------------------------------------
Filename:	wa2visualizer.m
Version:	2.1

Type:		maki
Date:		07. Okt. 2007 - 19:56 , May 24th 2021 - 2:13am UTC+1
Author:		Martin Poehlmann aka Deimos, Eris Lund (0x5066), mirzi
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
			www.martin.deimos.de.vu

Note:		Ripped from Winamp Modern, removed the VU Meter section
			this also includes the option to set the Spectrum 
			Analyzer coloring.
			Now resides in skin.xml to hook into the Main Window and
			Playlist Editor.
-----------------------------------------------------
---------------------------------------------------*/

#include "..\..\..\lib/std.mi"

Function refreshVisSettings();
Function setVis (int mode);
Function ProcessMenuResult (int a);
Function LegacyOptions(int legacy);
Function setVisModeLBD();
Function setVisModeRBD();
Function setWA265Mode(int wa_mode);
Function setFont(int font);

Global GuiObject PlayIndicator, Songticker, Infoticker;

Global Group MainWindow, MainClassicVis, Clutterbar;
Global Group MainShadeWindow, PLVis;
Global Group PLWindow;

Global Vis MainVisualizer, MainShadeVisualizer, PLVisualizer;
Global AnimatedLayer MainShadeVULeft, MainShadeVURight;
Global timer VU;
Global float level1, level2, peak1, peak2, pgrav1, pgrav2, vu_falloffspeed;

Global Button CLBV1, CLBV2, CLBV3;

Global PopUpMenu visMenu;
Global PopUpMenu pksmenu;
Global PopUpMenu anamenu;
Global PopUpMenu anasettings;
Global PopUpMenu oscsettings;
Global PopUpMenu stylemenu;
Global PopUpMenu fpsmenu;
Global PopUpMenu vumenu;

Global Int currentMode, a_falloffspeed, p_falloffspeed, osc_render, ana_render, a_coloring, v_fps, smoothvu;
Global Boolean show_peaks, isShade, compatibility, playLED, WA265MODE, WA5MODE, SKINNEDFONT;
Global layer MainTrigger, MainShadeTrigger, PLTrigger;

Global Layout WinampMainWindow;

System.onScriptLoaded()
{
	WinampMainWindow = getContainer("Main").getLayout("Normal");

	MainWindow = getContainer("Main").getLayout("Normal");
	PlayIndicator = MainWindow.findObject("playbackstatus");
	Songticker = MainWindow.findObject("Songticker");
	Infoticker = MainWindow.findObject("Infoticker");
	Clutterbar = MainWindow.findObject("mainwindow");
	CLBV1 = Clutterbar.getObject("CLB.V1");
	CLBV2 = Clutterbar.getObject("CLB.V2");
	CLBV3 = Clutterbar.getObject("CLB.V3");
	MainClassicVis = MainWindow.findObject("waclassicvis");
	MainVisualizer = MainClassicVis.getObject("wa.vis");
	MainTrigger = MainClassicVis.getObject("main.vis.trigger");

	MainShadeWindow = getContainer("Main").getLayout("shade");
	MainShadeVisualizer = MainShadeWindow.findObject("wa.vis");
	MainShadeVULeft = MainShadeWindow.findObject("wa.shade.vu.left");
	MainShadeVURight = MainShadeWindow.findObject("wa.shade.vu.right");
	MainShadeTrigger = MainShadeWindow.findObject("main.vis.trigger");

	pgrav1 = 0;
	pgrav2 = 0;

	VU = new Timer;
	VU.setdelay(16);
    VU.start();
    VU.onTimer();

	vu_falloffspeed = (2/100)+0.02;

	PLWindow = getContainer("pl").getLayout("normal");
	PLVis = PLWindow.findObject("waclassicplvis");
	PLVisualizer = PLVis.getObject("wa.vis");
	PLTrigger = PLVis.getObject("main.vis.trigger");

	MainVisualizer.setXmlParam("Peaks", integerToString(show_peaks));
	MainVisualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	MainVisualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
	MainVisualizer.setXmlParam("oscstyle", integerToString(osc_render));
	MainVisualizer.setXmlParam("bandwidth", integerToString(ana_render));

	MainShadeVisualizer.setXmlParam("Peaks", integerToString(show_peaks));
	MainShadeVisualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	MainShadeVisualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
	MainShadeVisualizer.setXmlParam("oscstyle", integerToString(osc_render));
	MainShadeVisualizer.setXmlParam("bandwidth", integerToString(ana_render));

	PLVisualizer.setXmlParam("Peaks", integerToString(show_peaks));
	PLVisualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	PLVisualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
	PLVisualizer.setXmlParam("oscstyle", integerToString(osc_render));
	PLVisualizer.setXmlParam("bandwidth", integerToString(ana_render));
	refreshVisSettings();
}

setFont(int font){
	if(font){
		Songticker.setXmlParam("font", "wasabi.font.default");
		Songticker.setXmlParam("y", "27");
		Songticker.setXmlParam("h", "9");

		Infoticker.setXmlParam("font", "wasabi.font.default");
		Infoticker.setXmlParam("y", "27");
		Infoticker.setXmlParam("offsety", "-1");
		Infoticker.setXmlParam("h", "9");
	}else{
		Songticker.setXmlParam("font", "arial");
		Songticker.setXmlParam("y", "22");
		Songticker.setXmlParam("h", "14");

		Infoticker.setXmlParam("font", "arial");
		Infoticker.setXmlParam("y", "24");
		Infoticker.setXmlParam("offsety", "-2");
		Infoticker.setXmlParam("h", "14");
	}
}

setWA265Mode(int wa_mode){
	if(WA5MODE){
			MainShadeVisualizer.setXmlParam("alpha", "255");
			MainShadeVULeft.setXmlParam("alpha", "0");
			MainShadeVURight.setXmlParam("alpha", "0");
		}else{
			if(currentMode == 1){
			if(wa_mode == 1){
				MainShadeVisualizer.setXmlParam("alpha", "0");
				MainShadeVULeft.setXmlParam("alpha", "255");
				MainShadeVURight.setXmlParam("alpha", "255");
			}else{
				MainShadeVisualizer.setXmlParam("alpha", "255");
				MainShadeVULeft.setXmlParam("alpha", "0");
				MainShadeVURight.setXmlParam("alpha", "0");
			}
		}else{
			MainShadeVisualizer.setXmlParam("alpha", "255");
			MainShadeVULeft.setXmlParam("alpha", "0");
			MainShadeVURight.setXmlParam("alpha", "0");
		}
	}
}

VU.onTimer(){
    level1 = (getLeftVuMeter()*MainShadeVULeft.getLength()/256);
    level2 = (getRightVuMeter()*MainShadeVURight.getLength()/256);

	if(peak1 >= MainShadeVULeft.getLength()){
		peak1 = MainShadeVULeft.getLength();
	}
	if (level1 >= peak1){
			peak1 = level1;
		}
	
		else{
			if(smoothvu == 1){
				peak1 -= vu_falloffspeed*2.65;
			}else{
				peak1 -= vu_falloffspeed*16;
			}
		}
	if(peak2 >= MainShadeVURight.getLength()){
		peak2 = MainShadeVURight.getLength();
	}
	if (level2 >= peak2){
			peak2 = level2;
		}
		else{
			if(smoothvu == 1){
				peak2 -= vu_falloffspeed*2.65;
			}else{
				peak2 -= vu_falloffspeed*16;
			}
		}


    MainShadeVULeft.gotoFrame(peak1);
    MainShadeVURight.gotoFrame(peak2);
}

System.onStop(){
	VU.start();
	peak1 = 0;
	peak2 = 0;
}

System.onPause(){
	if(currentMode == 1){
		VU.stop();
	}
}

System.onResume(){
	if(currentMode == 1){
		VU.start();
	}
}

System.onPlay(){
	if(currentMode == 1){
		VU.start();
	}
}

setVisModeLBD(){
	currentMode++;

	if (currentMode == 3)
	{
		currentMode = 0;
	}

	setVis (currentMode);
	setWA265Mode(WA265MODE);
	complete;
}

setVisModeRBD(){
	visMenu = new PopUpMenu;
	pksmenu = new PopUpMenu;
	anamenu = new PopUpMenu;
	stylemenu = new PopUpMenu;
	anasettings = new PopUpMenu;
	oscsettings = new PopUpMenu;
	fpsmenu = new PopUpMenu;
	vumenu = new PopUpMenu;

	if(WA5MODE){
		visMenu.addCommand("Modes:", 999, 0, 1);
		visMenu.addSeparator();
		visMenu.addCommand("Disabled", 100, currentMode == 0, 0);
		visMenu.addCommand("Spectrum Analyzer", 1, currentMode == 1, 0);
		visMenu.addCommand("Oscilloscope", 2, currentMode == 2, 0);
	}else{
		visMenu.addCommand("Visualization mode:", 999, 0, 1);
		visMenu.addSeparator();
		visMenu.addCommand("Off", 100, currentMode == 0, 0);
		if(WA265MODE == 1){
			visMenu.addCommand("Spectrum analyzer / Winshade VU", 1, currentMode == 1, 0);
		}else{
			visMenu.addCommand("Spectrum analyzer", 1, currentMode == 1, 0);
		}
	visMenu.addCommand("Oscilliscope", 2, currentMode == 2, 0);
	}

	visMenu.addSeparator();
	visMenu.addCommand("Main Window Settings", 998, 0, 1);
	visMenu.addCommand("Classic Skin Compatibility", 102, compatibility == 1, 0);
	visMenu.addCommand("Use bitmap font for main title display (no int. support)", 106, SKINNEDFONT == 1, 0);
	if(compatibility){
		//SORRY NOTHING
	}else{
		visMenu.addCommand("Playback Indicator", 103, playLED == 1, 0);
	}
	if(WA5MODE){
		//SORRY NOTHING
	}else{
		visMenu.addCommand("Winamp 2.65 mode (winshade)", 104, WA265MODE == 1, 0);
	}
	visMenu.addCommand("Winamp 5.x mode", 105, WA5MODE == 1, 0);
	visMenu.addSeparator();
	if(WA5MODE){
		visMenu.addSubmenu(fpsmenu, "Visualization refresh rate");
	}else{
	visMenu.addSubmenu(fpsmenu, "Refresh rate");
	}
	fpsmenu.addCommand("9fps", 800, v_fps == 0, 0);
	fpsmenu.addCommand("18fps", 802, v_fps == 2, 0);
	fpsmenu.addCommand("35fps", 803, v_fps == 3, 0);
	fpsmenu.addCommand("70fps", 804, v_fps == 4, 0);

	if(WA5MODE){
		visMenu.addSubmenu(anasettings, "Spectrum Analyzer Options");
		anasettings.addCommand("Band line width:", 997, 0, 1);
		anasettings.addSeparator();
		anasettings.addCommand("Thin", 701, ana_render == 1, 0);
		if(getDateDay(getDate()) == 1 && getDateMonth(getDate()) == 3){
			anasettings.addCommand("乇乂丅尺卂 丅卄工匚匚", 702, ana_render == 2, 0);
		}else{
			anasettings.addCommand("Thick", 702, ana_render == 2, 0);
		}
		anasettings.addSeparator();
		anasettings.addCommand("Show Peaks", 101, show_peaks == 1, 0);
		anasettings.addSeparator();
		pksmenu.addCommand("Slower", 200, p_falloffspeed == 0, 0);
		pksmenu.addCommand("Slow", 201, p_falloffspeed == 1, 0);
		pksmenu.addCommand("Moderate", 202, p_falloffspeed == 2, 0);
		pksmenu.addCommand("Fast", 203, p_falloffspeed == 3, 0);
		pksmenu.addCommand("Faster", 204, p_falloffspeed == 4, 0);
		anasettings.addSubMenu(pksmenu, "Peak falloff Speed");
		anamenu.addCommand("Slower", 300, a_falloffspeed == 0, 0);
		anamenu.addCommand("Slow", 301, a_falloffspeed == 1, 0);
		anamenu.addCommand("Moderate", 302, a_falloffspeed == 2, 0);
		anamenu.addCommand("Fast", 303, a_falloffspeed == 3, 0);
		anamenu.addCommand("Faster", 304, a_falloffspeed == 4, 0);
		anasettings.addSubMenu(anamenu, "Analyzer falloff Speed");
		visMenu.addSubmenu(oscsettings, "Oscilloscope Options");
		oscsettings.addCommand("Oscilloscope drawing style:", 996, 0, 1);
		oscsettings.addSeparator();
		oscsettings.addCommand("Dots", 603, osc_render == 3, 0);
		oscsettings.addCommand("Lines", 601, osc_render == 1, 0);
		oscsettings.addCommand("Solid", 602, osc_render == 2, 0);
	}else{
		visMenu.addSubmenu(anasettings, "Spectrum analyzer options");

		anasettings.addCommand("Normal style", 400, a_coloring == 0, 0);
		anasettings.addCommand("Fire style", 402, a_coloring == 2, 0);
		anasettings.addCommand("Line style", 403, a_coloring == 3, 0);
		anasettings.addSeparator();
		anasettings.addCommand("Peaks", 101, show_peaks == 1, 0);
		anasettings.addSeparator();
		anasettings.addCommand("Thin bands", 701, ana_render == 1, 0);
		if(getDateDay(getDate()) == 1 && getDateMonth(getDate()) == 3){
			anasettings.addCommand("乇乂丅尺卂 丅卄工匚匚", 702, ana_render == 2, 0);
		}else{
			anasettings.addCommand("Thick bands", 702, ana_render == 2, 0);
		}
		anasettings.addSeparator();

		anasettings.addSubMenu(anamenu, "Analyzer falloff");
		anamenu.addCommand("Slower", 300, a_falloffspeed == 0, 0);
		anamenu.addCommand("Slow", 301, a_falloffspeed == 1, 0);
		anamenu.addCommand("Moderate", 302, a_falloffspeed == 2, 0);
		anamenu.addCommand("Fast", 303, a_falloffspeed == 3, 0);
		anamenu.addCommand("Faster", 304, a_falloffspeed == 4, 0);
		anasettings.addSubMenu(pksmenu, "Peaks falloff");
		pksmenu.addCommand("Slower", 200, p_falloffspeed == 0, 0);
		pksmenu.addCommand("Slow", 201, p_falloffspeed == 1, 0);
		pksmenu.addCommand("Moderate", 202, p_falloffspeed == 2, 0);
		pksmenu.addCommand("Fast", 203, p_falloffspeed == 3, 0);
		pksmenu.addCommand("Faster", 204, p_falloffspeed == 4, 0);

		visMenu.addSubmenu(oscsettings, "Oscilliscope Options");
		oscsettings.addCommand("Dot scope", 601, osc_render == 1, 0);
		oscsettings.addCommand("Line scope", 602, osc_render == 2, 0);
		oscsettings.addCommand("Solid scope", 603, osc_render == 3, 0);
	}

	if(WA5MODE){
		//SORRY NOTHING
	}else{
		if(WA265MODE == 1){
			visMenu.addSubmenu(vumenu, "Winshade VU options");
			vumenu.addCommand("Normal VU", 901, smoothvu == 1, 0);
			vumenu.addCommand("Smooth VU", 902, smoothvu == 2, 0);
		}
	}

	visMenu.addSeparator();
	visMenu.addcommand(translate("Start/Stop plug-in")+"\tCtrl+Shift+K", 404, 0,0);
	visMenu.addcommand(translate("Configure plug-in...")+"\tAlt+K", 405, 0,0);
	visMenu.addcommand(translate("Select plug-in...")+"\tCtrl+K", 406, 0,0);

	ProcessMenuResult (visMenu.popAtMouse());

	setWA265Mode(WA265Mode); 
	if(compatibility){
		PlayIndicator.setXmlParam("visible", "1");
	}else{
		PlayIndicator.setXmlParam("visible", integerToString(playLED));
	}

	delete visMenu;
	delete pksmenu;
	delete anamenu;
	delete stylemenu;
	delete anasettings;
	delete oscsettings;
	delete fpsmenu;

	complete;	
}

refreshVisSettings ()
{
	currentMode = getPrivateInt(getSkinName(), "Visualizer Mode", 1);
	show_peaks = getPrivateInt(getSkinName(), "Visualizer show Peaks", 1);
	compatibility = getPrivateInt(getSkinName(), "DeClassified Classic Visualizer behavior", 1);
	a_falloffspeed = getPrivateInt(getSkinName(), "Visualizer analyzer falloff", 3);
	p_falloffspeed = getPrivateInt(getSkinName(), "Visualizer Peaks falloff", 2);
	osc_render = getPrivateInt(getSkinName(), "Oscilloscope Settings", 2);
	ana_render = getPrivateInt(getSkinName(), "Spectrum Analyzer Settings", 2);
	a_coloring = getPrivateInt(getSkinName(), "Visualizer analyzer coloring", 0);
	v_fps = getPrivateInt(getSkinName(), "Visualizer Refresh rate", 3);
	playLED = getPrivateInt(getSkinName(), "DeClassified Play LED", 1);
	WA265MODE = getPrivateInt(getSkinName(), "DeClassified Winamp 2.65 Mode", 1);
	smoothvu = getPrivateInt(getSkinName(), "DeClassified Winamp 2.65 VU Options", 1);
	WA5MODE = getPrivateInt(getSkinName(), "DeClassified Winamp 5.x Mode", 0);
	SKINNEDFONT = getPrivateInt(getSkinName(), "DeClassified Skinned Font", 1);

	if(compatibility){
		PlayIndicator.setXmlParam("visible", "1");
	}else{
		PlayIndicator.setXmlParam("visible", integerToString(playLED));
	}

	MainVisualizer.setXmlParam("Peaks", integerToString(show_peaks));
	MainVisualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	MainVisualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
	MainVisualizer.setXmlParam("oscstyle", integerToString(osc_render));
	MainVisualizer.setXmlParam("bandwidth", integerToString(ana_render));

	MainShadeVisualizer.setXmlParam("Peaks", integerToString(show_peaks));
	MainShadeVisualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	MainShadeVisualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
	MainShadeVisualizer.setXmlParam("oscstyle", integerToString(osc_render));
	MainShadeVisualizer.setXmlParam("bandwidth", integerToString(ana_render));

	PLVisualizer.setXmlParam("Peaks", integerToString(show_peaks));
	PLVisualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	PLVisualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
	PLVisualizer.setXmlParam("oscstyle", integerToString(osc_render));
	PLVisualizer.setXmlParam("bandwidth", integerToString(ana_render));

	if (a_coloring == 0)
	{
		MainVisualizer.setXmlParam("coloring", "Normal");
		MainShadeVisualizer.setXmlParam("coloring", "Normal");
		PLVisualizer.setXmlParam("coloring", "Normal");
	}
	else if (a_coloring == 1)
	{
		MainVisualizer.setXmlParam("coloring", "Normal");
		MainShadeVisualizer.setXmlParam("coloring", "Normal");
		PLVisualizer.setXmlParam("coloring", "Normal");
	}
	else if (a_coloring == 2)
	{
		MainVisualizer.setXmlParam("coloring", "Fire");
		MainShadeVisualizer.setXmlParam("coloring", "Fire");
		PLVisualizer.setXmlParam("coloring", "Fire");
	}
	else if (a_coloring == 3)
	{
		MainVisualizer.setXmlParam("coloring", "Line");
		MainShadeVisualizer.setXmlParam("coloring", "Line");
		PLVisualizer.setXmlParam("coloring", "Line");
	}

	if (osc_render == 0)
		{
			MainVisualizer.setXmlParam("oscstyle", "Dots");
			MainShadeVisualizer.setXmlParam("oscstyle", "Dots");
			PLVisualizer.setXmlParam("oscstyle", "Dots");
		}
		else if (osc_render == 1)
		{
			MainVisualizer.setXmlParam("oscstyle", "Dots");
			MainShadeVisualizer.setXmlParam("oscstyle", "Dots");
			PLVisualizer.setXmlParam("oscstyle", "Dots");
		}
		else if (osc_render == 2)
		{
			MainVisualizer.setXmlParam("oscstyle", "Solid");
			MainShadeVisualizer.setXmlParam("oscstyle", "Solid");
			PLVisualizer.setXmlParam("oscstyle", "Solid");
		}
		else if (osc_render == 3)
		{
			MainVisualizer.setXmlParam("oscstyle", "Lines");
			MainShadeVisualizer.setXmlParam("oscstyle", "Lines");
			PLVisualizer.setXmlParam("oscstyle", "Lines");
		}
	setPrivateInt(getSkinName(), "Oscilloscope Settings", osc_render);
    
	if (ana_render == 0)
		{
			MainVisualizer.setXmlParam("bandwidth", "Thin");
			MainShadeVisualizer.setXmlParam("bandwidth", "Thin");
			PLVisualizer.setXmlParam("bandwidth", "Thin");
		}
		else if (ana_render == 1)
		{
			MainVisualizer.setXmlParam("bandwidth", "Thin");
			MainShadeVisualizer.setXmlParam("bandwidth", "Thin");
			PLVisualizer.setXmlParam("bandwidth", "Thin");
		}
		else if (ana_render == 2)
		{
			MainVisualizer.setXmlParam("bandwidth", "wide");
			MainShadeVisualizer.setXmlParam("bandwidth", "wide");
			PLVisualizer.setXmlParam("bandwidth", "wide");
		}
	setPrivateInt(getSkinName(), "Spectrum Analyzer Settings", ana_render);

	if (v_fps == 0)
		{
			MainVisualizer.setXmlParam("fps", "9");
			MainShadeVisualizer.setXmlParam("fps", "9");
			PLVisualizer.setXmlParam("fps", "9");
		}
		else if (v_fps == 1)
		{
			MainVisualizer.setXmlParam("fps", "9");
			MainShadeVisualizer.setXmlParam("fps", "9");
			PLVisualizer.setXmlParam("fps", "9");
		}
		else if (v_fps == 2)
		{
			MainVisualizer.setXmlParam("fps", "18");
			MainShadeVisualizer.setXmlParam("fps", "18");
			PLVisualizer.setXmlParam("fps", "18");
		}
		else if (v_fps == 3)
		{
			MainVisualizer.setXmlParam("fps", "35");
			MainShadeVisualizer.setXmlParam("fps", "35");
			PLVisualizer.setXmlParam("fps", "35");
		}
		else if (v_fps == 4)
		{
			MainVisualizer.setXmlParam("fps", "70");
			MainShadeVisualizer.setXmlParam("fps", "70");
			PLVisualizer.setXmlParam("fps", "70");
		}
	setPrivateInt(getSkinName(), "Visualizer Refresh rate", v_fps);

	if (smoothvu == 0)
		{
			MainShadeVULeft.setXmlParam("image", "wa2.player.shade.normal.vu");
			MainShadeVULeft.setXmlParam("frameheight", "2");
			MainShadeVURight.setXmlParam("image", "wa2.player.shade.normal.vu");
			MainShadeVURight.setXmlParam("frameheight", "2");
		}
		else if (smoothvu == 1)
		{
			MainShadeVULeft.setXmlParam("image", "wa2.player.shade.normal.vu");
			MainShadeVULeft.setXmlParam("frameheight", "2");
			MainShadeVURight.setXmlParam("image", "wa2.player.shade.normal.vu");
			MainShadeVURight.setXmlParam("frameheight", "2");
		}
		else if (smoothvu == 2)
		{
			MainShadeVULeft.setXmlParam("image", "wa2.player.shade.smooth.vu");
			MainShadeVULeft.setXmlParam("frameheight", "1");
			MainShadeVURight.setXmlParam("image", "wa2.player.shade.smooth.vu");
			MainShadeVURight.setXmlParam("frameheight", "1");
		}
	setPrivateInt(getSkinName(), "DeClassified Winamp 2.65 VU Options", smoothvu);

	setVis (currentMode);
	LegacyOptions(compatibility);
	setWA265Mode(WA265MODE);
	setFont(SKINNEDFONT);
}

System.onStop(){
	LegacyOptions(compatibility);
}

System.onPlay(){
	LegacyOptions(compatibility);
}

System.onResume(){
	LegacyOptions(compatibility);
}

MainTrigger.onLeftButtonDown (int x, int y)
{
	setVisModeLBD();
}

MainShadeTrigger.onLeftButtonDown (int x, int y)
{
	setVisModeLBD();
}

PLTrigger.onLeftButtonDown (int x, int y)
{
	setVisModeLBD();
}

MainTrigger.onRightButtonUp (int x, int y)
{
	setVisModeRBD();
}

MainShadeTrigger.onRightButtonUp (int x, int y)
{
	setVisModeRBD();
}

PLTrigger.onRightButtonUp (int x, int y)
{
	setVisModeRBD();
}

ProcessMenuResult (int a)
{
	if (a < 1) return;

	if (a > 0 && a <= 6 || a == 100)
	{
		if (a == 100) a = 0;
		setVis(a);
	}

	else if (a == 101)
	{
		show_peaks = (show_peaks - 1) * (-1);
		MainVisualizer.setXmlParam("Peaks", integerToString(show_peaks));
		MainShadeVisualizer.setXmlParam("Peaks", integerToString(show_peaks));
		PLVisualizer.setXmlParam("Peaks", integerToString(show_peaks));
		setPrivateInt(getSkinName(), "Visualizer show Peaks", show_peaks);
	}

	else if (a == 102)
	{
		compatibility = (compatibility - 1) * (-1);
		LegacyOptions(compatibility);
		setPrivateInt(getSkinName(), "DeClassified Classic Visualizer behavior", compatibility);
	}

	else if (a == 103)
		{
			playLED = (playLED - 1) * (-1);
			if(compatibility){
				PlayIndicator.setXmlParam("visible", "1");
			}else{
				PlayIndicator.setXmlParam("visible", integerToString(playLED));
			}
			setPrivateInt(getSkinName(), "DeClassified Play LED", playLED);
		}

	else if (a == 104)
		{
			WA265MODE = (WA265MODE - 1) * (-1);
			setWA265Mode(WA265MODE);
			setPrivateInt(getSkinName(), "DeClassified Winamp 2.65 Mode", WA265MODE);
		}

	else if (a == 105)
		{
			WA5MODE = (WA5MODE - 1) * (-1);
			setPrivateInt(getSkinName(), "DeClassified Winamp 5.x Mode", WA5MODE);
		}

	else if (a == 106)
		{
			SKINNEDFONT = (SKINNEDFONT - 1) * (-1);
			setFont(SKINNEDFONT);
			setPrivateInt(getSkinName(), "DeClassified Skinned Font", SKINNEDFONT);
		}

	else if (a >= 200 && a <= 204)
	{
		p_falloffspeed = a - 200;
		MainVisualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
		MainShadeVisualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
		PLVisualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
		setPrivateInt(getSkinName(), "Visualizer Peaks falloff", p_falloffspeed);
	}

	else if (a >= 300 && a <= 304)
	{
		a_falloffspeed = a - 300;
		MainVisualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
		MainShadeVisualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
		PLVisualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
		setPrivateInt(getSkinName(), "Visualizer analyzer falloff", a_falloffspeed);
	}

else if (a >= 400 && a <= 403)
	{
		a_coloring = a - 400;
		if (a_coloring == 0)
		{
			MainVisualizer.setXmlParam("coloring", "Normal");
			MainShadeVisualizer.setXmlParam("coloring", "Normal");
			PLVisualizer.setXmlParam("coloring", "Normal");
		}
		else if (a_coloring == 1)
		{
			MainVisualizer.setXmlParam("coloring", "Normal");
			MainShadeVisualizer.setXmlParam("coloring", "Normal");
			PLVisualizer.setXmlParam("coloring", "Normal");
		}
		else if (a_coloring == 2)
		{
			MainVisualizer.setXmlParam("coloring", "Fire");
			MainShadeVisualizer.setXmlParam("coloring", "Fire");
			PLVisualizer.setXmlParam("coloring", "Fire");
		}
		else if (a_coloring == 3)
		{
			MainVisualizer.setXmlParam("coloring", "Line");
			MainShadeVisualizer.setXmlParam("coloring", "Line");
			PLVisualizer.setXmlParam("coloring", "Line");
		}
		setPrivateInt(getSkinName(), "Visualizer analyzer coloring", a_coloring);
	}

	else if (a == 404)
	{
		CLBV1.Leftclick();
	}
	else if (a == 405)
	{
		CLBV2.Leftclick();
	}
	else if (a == 406)
	{
		CLBV3.Leftclick();
	}

	else if (a >= 600 && a <= 603)
	{
		osc_render = a - 600;
		if (osc_render == 0)
		{
			MainVisualizer.setXmlParam("oscstyle", "Dots");
			MainShadeVisualizer.setXmlParam("oscstyle", "Dots");
			PLVisualizer.setXmlParam("oscstyle", "Dots");
		}
		else if (osc_render == 1)
		{
			MainVisualizer.setXmlParam("oscstyle", "Dots");
			MainShadeVisualizer.setXmlParam("oscstyle", "Dots");
			PLVisualizer.setXmlParam("oscstyle", "Dots");
		}
		else if (osc_render == 2)
		{
			MainVisualizer.setXmlParam("oscstyle", "Solid");
			MainShadeVisualizer.setXmlParam("oscstyle", "Solid");
			PLVisualizer.setXmlParam("oscstyle", "Solid");
		}
		else if (osc_render == 3)
		{
			MainVisualizer.setXmlParam("oscstyle", "Lines");
			MainShadeVisualizer.setXmlParam("oscstyle", "Lines");
			PLVisualizer.setXmlParam("oscstyle", "Lines");
		}
	setPrivateInt(getSkinName(), "Oscilloscope Settings", osc_render);
	}

    else if (a >= 700 && a <= 702)
	{
		ana_render = a - 700;
		if (ana_render == 0)
		{
			MainVisualizer.setXmlParam("bandwidth", "Thin");
			MainShadeVisualizer.setXmlParam("bandwidth", "Thin");
			PLVisualizer.setXmlParam("bandwidth", "Thin");
		}
		else if (ana_render == 1)
		{
			MainVisualizer.setXmlParam("bandwidth", "Thin");
			MainShadeVisualizer.setXmlParam("bandwidth", "Thin");
			PLVisualizer.setXmlParam("bandwidth", "Thin");
		}
		else if (ana_render == 2)
		{
			MainVisualizer.setXmlParam("bandwidth", "wide");
			MainShadeVisualizer.setXmlParam("bandwidth", "wide");
			PLVisualizer.setXmlParam("bandwidth", "wide");
		}
	setPrivateInt(getSkinName(), "Spectrum Analyzer Settings", ana_render);
	}

	else if (a >= 800 && a <= 804)
	{
		v_fps = a - 800;
		if (v_fps == 0)
		{
			MainVisualizer.setXmlParam("fps", "9");
			MainShadeVisualizer.setXmlParam("fps", "9");
			PLVisualizer.setXmlParam("fps", "9");
		}
		else if (v_fps == 1)
		{
			MainVisualizer.setXmlParam("fps", "9");
			MainShadeVisualizer.setXmlParam("fps", "9");
			PLVisualizer.setXmlParam("fps", "9");
		}
		else if (v_fps == 2)
		{
			MainVisualizer.setXmlParam("fps", "18");
			MainShadeVisualizer.setXmlParam("fps", "18");
			PLVisualizer.setXmlParam("fps", "18");
		}
		else if (v_fps == 3)
		{
			MainVisualizer.setXmlParam("fps", "35");
			MainShadeVisualizer.setXmlParam("fps", "35");
			PLVisualizer.setXmlParam("fps", "35");
		}
		else if (v_fps == 4)
		{
			MainVisualizer.setXmlParam("fps", "70");
			MainShadeVisualizer.setXmlParam("fps", "70");
			PLVisualizer.setXmlParam("fps", "70");
		}
		setPrivateInt(getSkinName(), "Visualizer Refresh rate", v_fps);
	}

	else if (a >= 900 && a <= 902)
	{
		smoothvu = a - 900;
		if (smoothvu == 0)
			{
				MainShadeVULeft.setXmlParam("image", "wa2.player.shade.normal.vu");
				MainShadeVULeft.setXmlParam("frameheight", "2");
				MainShadeVURight.setXmlParam("image", "wa2.player.shade.normal.vu");
				MainShadeVURight.setXmlParam("frameheight", "2");
			}
			else if (smoothvu == 1)
			{
				MainShadeVULeft.setXmlParam("image", "wa2.player.shade.normal.vu");
				MainShadeVULeft.setXmlParam("frameheight", "2");
				MainShadeVURight.setXmlParam("image", "wa2.player.shade.normal.vu");
				MainShadeVURight.setXmlParam("frameheight", "2");
			}
			else if (smoothvu == 2)
			{
				MainShadeVULeft.setXmlParam("image", "wa2.player.shade.smooth.vu");
				MainShadeVULeft.setXmlParam("frameheight", "1");
				MainShadeVURight.setXmlParam("image", "wa2.player.shade.smooth.vu");
				MainShadeVURight.setXmlParam("frameheight", "1");
			}
		setPrivateInt(getSkinName(), "DeClassified Winamp 2.65 VU Options", smoothvu);
	}
}

setVis (int mode)
{
	setPrivateInt(getSkinName(), "Visualizer Mode", mode);
	if (mode == 0)
	{
		MainVisualizer.setMode(0);
		MainShadeVisualizer.setMode(0);
		PLVisualizer.setMode(0);
		setWA265Mode(WA265MODE);
		VU.stop();
	}
	else if (mode == 1)
	{
		MainVisualizer.setMode(1);
		MainShadeVisualizer.setMode(1);
		PLVisualizer.setMode(1);
		setWA265Mode(WA265MODE);
		VU.start();
	}
	else if (mode == 2)
	{
		MainVisualizer.setMode(2);
		MainShadeVisualizer.setMode(2);
		PLVisualizer.setMode(2);
		setWA265Mode(WA265MODE);
		VU.stop();
	}
	currentMode = mode;
}

LegacyOptions(int legacy){
	//messageBox(integertoString(legacy), "", 1, "");
	if(legacy == 1){
		WinampMainWindow.onSetVisible(WinampMainWindow.isVisible());
		if(getStatus() == -1){
			MainVisualizer.setXmlParam("visible", "1");
			MainShadeVisualizer.setXmlParam("visible", "1");
			PLVisualizer.setXmlParam("visible", "1");
		}else if(getStatus() == 0){
			MainVisualizer.setXmlParam("visible", "0");
			MainShadeVisualizer.setXmlParam("visible", "0");
			PLVisualizer.setXmlParam("visible", "0");
		}else if(getStatus() == 1){
			MainVisualizer.setXmlParam("visible", "1");
			MainShadeVisualizer.setXmlParam("visible", "1");
			PLVisualizer.setXmlParam("visible", "1");
		}
		if(WinampMainWindow.getScale() != 2){
		MainVisualizer.setXmlParam("y", "2");
		PLVisualizer.setXmlParam("y", "2");
		}else{
		MainVisualizer.setXmlParam("y", "0");
		PLVisualizer.setXmlParam("y", "0");
		}
	}else{
		MainVisualizer.setXmlParam("visible", "1");
		MainShadeVisualizer.setXmlParam("visible", "1");
		PLVisualizer.setXmlParam("visible", "1");
		MainVisualizer.setXmlParam("y", "0");
		PLVisualizer.setXmlParam("y", "0");
		WinampMainWindow.onSetVisible(0);
	}
}

WinampMainWindow.onScale(Double newscalevalue){
	LegacyOptions(compatibility);
	if(legacy == 1){
		if(newscalevalue != 2){
			MainVisualizer.setXmlParam("y", "2");
			PLVisualizer.setXmlParam("y", "2");
		}else{
			MainVisualizer.setXmlParam("y", "0");
			PLVisualizer.setXmlParam("y", "0");
		}
	}else{
		MainVisualizer.setXmlParam("y", "0");
		PLVisualizer.setXmlParam("y", "0");
	}
}

WinampMainWindow.onSetVisible(Boolean onoff){
	if(onoff == 1){
		PLVisualizer.setXmlParam("alpha", "0");
	}else{
		PLVisualizer.setXmlParam("alpha", "255");
	}
	if(legacy == 0){
		PLVisualizer.setXmlParam("alpha", "255");
	}
}