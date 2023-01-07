#include "../../../lib/std.mi"
#include "../../../lib/winampconfig.mi"

Global Group frameGroup;
Global Slider eq1tip, eq2tip, eq3tip, eq4tip, eq5tip, eq6tip, eq7tip, eq8tip, eq9tip, eq10tip;
Global GuiObject EQBG, eqtitlebar, viseq, eqswitch, eqclose, eqon, eqauto, eqpresets;
Global Layer eq1ttip, eq2ttip, eq3ttip, eq4ttip, eq5ttip, eq6ttip, eq7ttip, eq8ttip, eq9ttip, eq10ttip;
Global WinampConfigGroup eqwcg;

#define ISOBANDS "31.5 Hz,63 Hz,125 Hz,250 Hz,500 Hz,1 KHz,2 KHz,4 KHz,8 KHz,16 KHz"
#define WINAMPBANDS "70 Hz,180 Hz,320 Hz,600 Hz,1 KHz,3 KHz,6 KHz,12 KHz,14 KHz,16 KHz"

System.onScriptLoaded() {
	eqwcg = WinampConfig.getGroup("{72409F84-BAF1-4448-8211-D84A30A1591A}");
	int freqmode = eqwcg.getInt("frequencies"); // returns 0 for classical winamp levels, 1 for ISO levels

	frameGroup = getScriptGroup();
    EQBG = frameGroup.findObject("eq.bg");
    eqtitlebar = frameGroup.findObject("waeq.titlebar");
    viseq = frameGroup.findObject("waeq.eqvis");
    eqswitch = frameGroup.findObject("eq.switch");
    eqclose = frameGroup.findObject("eq.close");
    eqon = frameGroup.findObject("eq.on");
    eqauto = frameGroup.findObject("eq.auto");
    eqpresets = frameGroup.findObject("eq.presets");
    eq1tip = frameGroup.getObject("eq1");
    eq2tip = frameGroup.getObject("eq2");
    eq3tip = frameGroup.getObject("eq3");
    eq4tip = frameGroup.getObject("eq4");
    eq5tip = frameGroup.getObject("eq5");
    eq6tip = frameGroup.getObject("eq6");
    eq7tip = frameGroup.getObject("eq7");
    eq8tip = frameGroup.getObject("eq8");
    eq9tip = frameGroup.getObject("eq9");
    eq10tip = frameGroup.getObject("eq10");
    eq1ttip = frameGroup.getObject("eq1back");
    eq2ttip = frameGroup.getObject("eq2back");
    eq3ttip = frameGroup.getObject("eq3back");
    eq4ttip = frameGroup.getObject("eq4back");
    eq5ttip = frameGroup.getObject("eq5back");
    eq6ttip = frameGroup.getObject("eq6back");
    eq7ttip = frameGroup.getObject("eq7back");
    eq8ttip = frameGroup.getObject("eq8back");
    eq9ttip = frameGroup.getObject("eq9back");
    eq10ttip = frameGroup.getObject("eq10back");

	system.onEqFreqChanged(freqmode);
}

System.onEqFreqChanged(boolean isoonoff)
{
	if (isoonoff == 1)
	{
        EQBG.setXmlParam("image", "wa.iso.eq");
        eqtitlebar.setXmlParam("image", "waisoeq.titlebar.on");
        eqtitlebar.setXmlParam("inactiveimage", "waisoeq.titlebar.off");
        viseq.setXmlParam("image", "wa.iso.eqvis.bg");
        eqswitch.setXmlParam("image", "iso.eq.switch");
        eqclose.setXmlParam("image", "iso.eq.close");
        eqon.setXmlParam("image", "iso.eq.off");
        eqon.setXmlParam("downimage", "iso.eq.offp");
        eqon.setXmlParam("activeimage", "iso.eq.on");
        eqauto.setXmlParam("image", "iso.eq.auto");
        eqauto.setXmlParam("downimage", "iso.eq.autop");
        eqauto.setXmlParam("activeimage", "iso.eq.autoon");
        eqpresets.setXmlParam("image", "iso.eq.presets");
        eqpresets.setXmlParam("downimage", "iso.eq.presetsp");
        eq1tip.setXMLParam("tooltip", "31.5Hz");
        eq2tip.setXMLParam("tooltip", "63Hz");
        eq3tip.setXMLParam("tooltip", "125Hz");
        eq4tip.setXMLParam("tooltip", "250Hz");
        eq5tip.setXMLParam("tooltip", "500Hz");
        eq6tip.setXMLParam("tooltip", "1KHz");
        eq7tip.setXMLParam("tooltip", "2KHz");
        eq8tip.setXMLParam("tooltip", "4KHz");
        eq9tip.setXMLParam("tooltip", "8KHz");
        eq10tip.setXMLParam("tooltip", "16KHz");
        eq1ttip.setXMLParam("tooltip", "31.5Hz");
        eq2ttip.setXMLParam("tooltip", "63Hz");
        eq3ttip.setXMLParam("tooltip", "125Hz");
        eq4ttip.setXMLParam("tooltip", "250Hz");
        eq5ttip.setXMLParam("tooltip", "500Hz");
        eq6ttip.setXMLParam("tooltip", "1KHz");
        eq7ttip.setXMLParam("tooltip", "2KHz");
        eq8ttip.setXMLParam("tooltip", "4KHz");
        eq9ttip.setXMLParam("tooltip", "8KHz");
        eq10ttip.setXMLParam("tooltip", "16KHz");
        //messageBox("Equalizer mode is "+integerToString(isoonoff), "Equalizer mode", 1, "");
	}
	else
	{
        EQBG.setXmlParam("image", "wa.eq");
        eqtitlebar.setXmlParam("image", "waeq.titlebar.on");
        eqtitlebar.setXmlParam("inactiveimage", "waeq.titlebar.off");
        viseq.setXmlParam("image", "wa.eqvis.bg");
        eqswitch.setXmlParam("image", "eq.switch");
        eqclose.setXmlParam("image", "eq.close");
        eqon.setXmlParam("image", "eq.off");
        eqon.setXmlParam("downimage", "eq.offp");
        eqon.setXmlParam("activeimage", "eq.on");
        eqauto.setXmlParam("image", "eq.auto");
        eqauto.setXmlParam("downimage", "eq.autop");
        eqauto.setXmlParam("activeimage", "eq.autoon");
        eqpresets.setXmlParam("image", "eq.presets");
        eqpresets.setXmlParam("downimage", "eq.presetsp");
        eq1tip.setXMLParam("tooltip", "70Hz");
        eq2tip.setXMLParam("tooltip", "180Hz");
        eq3tip.setXMLParam("tooltip", "320Hz");
        eq4tip.setXMLParam("tooltip", "600Hz");
        eq5tip.setXMLParam("tooltip", "1KHz");
        eq6tip.setXMLParam("tooltip", "3KHz");
        eq7tip.setXMLParam("tooltip", "6KHz");
        eq8tip.setXMLParam("tooltip", "12KHz");
        eq9tip.setXMLParam("tooltip", "14KHz");
        eq10tip.setXMLParam("tooltip", "16KHz");
        eq1ttip.setXMLParam("tooltip", "70Hz");
        eq2ttip.setXMLParam("tooltip", "180Hz");
        eq3ttip.setXMLParam("tooltip", "320Hz");
        eq4ttip.setXMLParam("tooltip", "600Hz");
        eq5ttip.setXMLParam("tooltip", "1KHz");
        eq6ttip.setXMLParam("tooltip", "3KHz");
        eq7ttip.setXMLParam("tooltip", "6KHz");
        eq8ttip.setXMLParam("tooltip", "12KHz");
        eq9ttip.setXMLParam("tooltip", "14KHz");
        eq10ttip.setXMLParam("tooltip", "16KHz");
        //messageBox("Equalizer mode is "+integerToString(isoonoff), "Equalizer mode", 1, "");
	}
}