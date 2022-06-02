#include "..\..\..\lib/std.mi"

Global Group EQg;
Global Button btnEQ0, btnEQ1, btnEQ2;
Global Layer eq1back, eq2back, eq3back, eq4back, eq5back, eq6back, eq7back, eq8back, eq9back, eq10back;
Global Boolean manual_set;

Global Layout normal;

System.onScriptLoaded() {

	EQg = getScriptGroup();

    eq1back = EQg.getObject("eq1back");
    eq2back = EQg.getObject("eq2back");
    eq3back = EQg.getObject("eq3back");
    eq4back = EQg.getObject("eq4back");
    eq5back = EQg.getObject("eq5back");
    eq6back = EQg.getObject("eq6back");
    eq7back = EQg.getObject("eq7back");
    eq8back = EQg.getObject("eq8back");
    eq9back = EQg.getObject("eq9back");
    eq10back = EQg.getObject("eq10back");

	normal = EQg.getParentLayout();
    btnEQ0 = EQg.findObject("12db");
	btnEQ1 = EQg.findObject("0db");
    btnEQ2 = EQg.findObject("-12db");

    //system.onEqFreqChanged(freqmode);
}

btnEQ0.onLeftClick() {
	manual_set = 1;
	for(int i=0; i<10; i++) setEqBand(i, 127);
	manual_set = 0;

    eq1back.setXMLParam("image", "eq.slider14");
    eq2back.setXMLParam("image", "eq.slider14");
    eq3back.setXMLParam("image", "eq.slider14");
    eq4back.setXMLParam("image", "eq.slider14");
    eq5back.setXMLParam("image", "eq.slider14");
    eq6back.setXMLParam("image", "eq.slider14");
    eq7back.setXMLParam("image", "eq.slider14");
    eq8back.setXMLParam("image", "eq.slider14");
    eq9back.setXMLParam("image", "eq.slider14");
    eq10back.setXMLParam("image", "eq.slider14");
}

btnEQ1.onLeftClick() {
	manual_set = 1;
	for(int i=0; i<10; i++) setEqBand(i, 1);
	manual_set = 0;

    eq1back.setXMLParam("image", "eq.slider0");
    eq2back.setXMLParam("image", "eq.slider0");
    eq3back.setXMLParam("image", "eq.slider0");
    eq4back.setXMLParam("image", "eq.slider0");
    eq5back.setXMLParam("image", "eq.slider0");
    eq6back.setXMLParam("image", "eq.slider0");
    eq7back.setXMLParam("image", "eq.slider0");
    eq8back.setXMLParam("image", "eq.slider0");
    eq9back.setXMLParam("image", "eq.slider0");
    eq10back.setXMLParam("image", "eq.slider0");
}

btnEQ2.onLeftClick() {
	manual_set = 1;
	for(int i=0; i<10; i++) setEqBand(i, -127);
	manual_set = 0;
    eq1back.setXMLParam("image", "eq.slider-14");
    eq2back.setXMLParam("image", "eq.slider-14");
    eq3back.setXMLParam("image", "eq.slider-14");
    eq4back.setXMLParam("image", "eq.slider-14");
    eq5back.setXMLParam("image", "eq.slider-14");
    eq6back.setXMLParam("image", "eq.slider-14");
    eq7back.setXMLParam("image", "eq.slider-14");
    eq8back.setXMLParam("image", "eq.slider-14");
    eq9back.setXMLParam("image", "eq.slider-14");
    eq10back.setXMLParam("image", "eq.slider-14");
}