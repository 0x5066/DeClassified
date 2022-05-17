//Taken straight out of Winamp Modern's display.m.
//Modified to include the Volume change, balance change,
//EQ change messages. Also hooks into the Main Window
//and Equalizer for obvious reasons.

#include "../../../lib/std.mi"
#include "..\..\..\lib/winampconfig.mi"

Global Group frameGroup;
Global Text displayvolume, FreqBands;

Global Slider Seeker;
Global Int Seeking;
Global Boolean manual_set;

#define ISOBANDS "31.5 Hz,63 Hz,125 Hz,250 Hz,500 Hz,1 KHz,2 KHz,4 KHz,8 KHz,16 KHz"
#define WINAMPBANDS "70 Hz,180 Hz,320 Hz,600 Hz,1 KHz,3 KHz,6 KHz,12 KHz,14 KHz,16 KHz"

System.onScriptLoaded(){

    WinampConfigGroup eqwcg = WinampConfig.getGroup("{72409F84-BAF1-4448-8211-D84A30A1591A}");
	int freqmode = eqwcg.getInt("frequencies"); // returns 0 for classical winamp levels, 1 for ISO levels

	frameGroup = getScriptGroup();
    
	displayvolume = frameGroup.findObject("displayvolume");
	FreqBands = frameGroup.findObject("FreqBands");
    System.onvolumechanged(getVolume());
    System.onEqFreqChanged(freqmode);
}

System.onvolumechanged(int newvol)
{
	displayvolume.setText(translate("Volume") + ": " + integerToString(newvol/2.55) + "%");
}

System.onEqFreqChanged(boolean isoonoff)
{
	if (isoonoff == 1)
	{
        FreqBands.setXmlParam("text", "Frequency Bands: ISO Standard frequency bands");
	}
	else
	{
        FreqBands.setXmlParam("text", "Frequency Bands: Winamp frequency bands");
	}
}
