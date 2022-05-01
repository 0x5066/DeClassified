//Taken straight out of Winamp Modern's display.m.
//Modified to include the Volume change messages.

#include "../../../lib/std.mi"

Global Group frameGroup, frameGroupEQ;
Global Togglebutton ShuffleBtn, RepeatBtn/*, CLBA*/;
Global Timer SongTickerTimer;
Global Text InfoTicker;
Global GuiObject SongTicker;
Global Slider Balance, BalanceEQ;
Global Layout Normal, ShadeEQ;

System.onScriptLoaded() {

	frameGroup = getContainer("Main").getLayout("Normal");
    frameGroupEQ = getContainer("eq").getLayout("shadeeq");
	SongTicker = frameGroup.findObject("songticker");
	InfoTicker = frameGroup.findObject("infoticker");
	normal = getContainer("main").getlayout("normal");
    shadeeq = getContainer("eq").getlayout("shadeeq");

	SongTickerTimer = new Timer;
	SongTickerTimer.setDelay(1000);

	RepeatBtn = frameGroup.findObject("Repeat");
	ShuffleBtn = frameGroup.findObject("Shuffle");
    //CLBA = frameGroup.findObject("CLB.A");

	Balance = frameGroup.findObject("Balance");
    BalanceEQ = frameGroupEQ.findObject("Balance");
}

Normal.onAction (String action, String param, Int x, int y, int p1, int p2, GuiObject source)
{
	if (strlower(action) == "showinfo")
	{
		SongTicker.hide();
		SongTickerTimer.start();
		InfoTicker.setText(param);
		InfoTicker.show();

	}
	else if (strlower(action) == "cancelinfo")
	{
		SongTickerTimer.onTimer();
	}
}

SongTickerTimer.onTimer() {
	SongTicker.show();
	InfoTicker.hide();
	SongTickerTimer.stop();
}

System.onScriptUnloading() {
	delete SongTickerTimer;
}

Balance.onSetPosition(int newpos)
{
	string t=translate("Balance")+":";
	if (newpos==127) t+= " " + translate("Center");
	if (newpos<127) t += " " + integerToString((100-(newpos/127)*100))+"% "+translate("Left");
	if (newpos>127) t += " " + integerToString(((newpos-127)/127)*100)+"% "+translate("Right");

	SongTickerTimer.start();
	SongTicker.hide();
	InfoTicker.show();
	InfoTicker.setText(t);
}

System.onvolumechanged(int newvol)
{
	SongTickerTimer.start();
	SongTicker.hide();
	InfoTicker.show();
	InfoTicker.setText(translate("Volume") + ": " + integerToString(newvol/2.55) + "%");
}

RepeatBtn.onToggle(boolean on) {
	SongTickerTimer.start();
	int v = getCurCfgVal();
	SongTicker.hide();
	InfoTicker.show();
    if (on) InfoTicker.setText("Repeat: ON"); else InfoTicker.setText("Repeat: OFF");
}

ShuffleBtn.onToggle(boolean on) {
	SongTickerTimer.start();
	SongTicker.hide();
	InfoTicker.show();
	if (on) InfoTicker.setText("Shuffle: ON"); else InfoTicker.setText("Shuffle: OFF");
}
/*
CLBA.onToggle(boolean on) {
	SongTickerTimer.start();
	SongTicker.hide();
	InfoTicker.show();
	if (on) InfoTicker.setText("Enable Always-on-Top"); else InfoTicker.setText("Disable Always-on-Top");
}*/

shadeEQ.onAction (String action, String param, Int x, int y, int p1, int p2, GuiObject source)
{
	if (strlower(action) == "showinfo")
	{
		SongTicker.hide();
		SongTickerTimer.start();
		InfoTicker.setText(param);
		InfoTicker.show();

	}
	else if (strlower(action) == "cancelinfo")
	{
		SongTickerTimer.onTimer ();
	}
}

BalanceEQ.onSetPosition(int newpos)
{
	string t=translate("Balance")+":";
	if (newpos==127) t+= " " + translate("Center");
	if (newpos<127) t += " " + integerToString((100-(newpos/127)*100))+"% "+translate("Left");
	if (newpos>127) t += " " + integerToString(((newpos-127)/127)*100)+"% "+translate("Right");

	SongTickerTimer.start();
	SongTicker.hide();
	InfoTicker.show();
	InfoTicker.setText(t);
}