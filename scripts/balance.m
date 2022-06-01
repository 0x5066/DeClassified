//Taken from Victhor's Winamp Classic Modern, which was
//deeply nested inside it's mainplayer.m script.

#include "..\..\..\lib/std.mi"

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
	
		if (v==127) aniBalance.gotoFrame(15);
		if (v<127) v = (27-(v/127)*27); 
		if (v>127) v = ((v-127)/127)*27;
	
	aniBalance.gotoFrame(v);

	messagebox(integertostring(Balance.GetPosition()), "", 1, "");
}

Balance.onSetPosition(int newpos)
{
	int v = newpos;
	
		if (newpos==127) aniBalance.gotoFrame(15);
		if (newpos<127) v = (27-(newpos/127)*27); 
		if (newpos>127) v = ((newpos-127)/127)*27;
	
	aniBalance.gotoFrame(v);
}

BalanceEQ.onSetPosition(int newpos)
{
	int v = newpos;
	
		if (newpos==127) aniBalance.gotoFrame(15);
		if (newpos<127) v = (27-(newpos/127)*27); 
		if (newpos>127) v = ((newpos-127)/127)*27;
	
	aniBalance.gotoFrame(v);
}