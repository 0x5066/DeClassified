//Taken from Victhor's Winamp Classic Modern, which was
//deeply nested inside it's mainplayer.m script.

#include "compiler/lib/std.mi"

Global Group player, slidersgroup, slidersgroup2, frameGroupEQShade;

Global AnimatedLayer aniBalance;
Global Slider Balance, BalanceEQ;

System.onScriptLoaded() {
	player = getContainer("Main").getLayout("Normal");
	SlidersGroup = player.findObject("sliders");

	aniBalance = SlidersGroup.getObject("balanceanim");
	Balance = SlidersGroup.getObject("balance");

	frameGroupEQShade = getContainer("eq").getLayout("shadeeq");
	SlidersGroup2 = frameGroupEQShade.findObject("shade.eq");

    BalanceEQ = SlidersGroup2.getObject("Balance");

	int v = BalanceEQ.GetPosition();
	
	v = v * 27 / 256;
	
	aniBalance.gotoFrame(v);
}

Balance.onSetPosition(int newpos) {
	int v = newPos * 27 / 256;
	
	aniBalance.gotoFrame(v);
}

BalanceEQ.onSetPosition(int newpos) {
	int v = newPos * 27 / 256;
	
	aniBalance.gotoFrame(v);
}