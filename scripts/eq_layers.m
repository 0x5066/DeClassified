#include "..\..\..\lib/std.mi"
#include "..\..\..\lib/winampconfig.mi"

Global Slider pre;
Global Layer pre_layer;
Global String XMLtext;
Global WinampConfigGroup eqwcg;
Global Group EQ;
Global int freqmode;
Function int GetSliderValue(int currentslider);

#define ISOBANDS "31.5 Hz,63 Hz,125 Hz,250 Hz,500 Hz,1 KHz,2 KHz,4 KHz,8 KHz,16 KHz"
#define WINAMPBANDS "70 Hz,180 Hz,320 Hz,600 Hz,1 KHz,3 KHz,6 KHz,12 KHz,14 KHz,16 KHz"

System.onScriptLoaded()
{
    eqwcg = WinampConfig.getGroup("{72409F84-BAF1-4448-8211-D84A30A1591A}");
	freqmode = eqwcg.getInt("frequencies"); // returns 0 for classical winamp levels, 1 for ISO levels

    EQ = getScriptGroup();
    pre = EQ.getObject("preamp");
    pre_layer = EQ.getObject("preamp_layer");

    system.onEqFreqChanged(freqmode);
}


System.onEqFreqChanged(boolean isoonoff)
{
    XMLtext = "iso.eq.slider"+integerToString(GetSliderValue(pre.getPosition()));
    pre_layer.setXMLParam("image", XMLtext);
    for(int i = 1; i <= 10; i++){
        Slider current = EQ.getObject("eq"+integertostring(i));

        XMLtext = "eq.slider" + integerToString( GetSliderValue( current.getPosition() ) );

        if (isoonoff == 1) XMLtext = "iso." + XMLtext;
        
        EQ.getObject("eq"+integertostring(i)+"back").setXMLParam("image", XMLtext);
    }
}

System.onEqPreampChanged(int newvalue)
{
    freqmode = eqwcg.getInt("frequencies");
    if (freqmode == 1)
	{
        XMLtext = "iso.eq.slider"+integerToString(GetSliderValue(newvalue));
    }else{
        XMLtext = "eq.slider"+integerToString(GetSliderValue(newvalue));
    }
    pre_layer.setXMLParam("image", XMLtext);

}

System.onEqBandChanged(int band, int newvalue){
    freqmode = eqwcg.getInt("frequencies");
    if (freqmode == 1){
        XMLtext = "iso.eq.slider"+integerToString(GetSliderValue(newvalue));
    }else{
        XMLtext = "eq.slider"+integerToString(GetSliderValue(newvalue));
    }
    band++;

    EQ.getObject("eq"+integertostring(band)+"back").setXMLParam("image", XMLtext);
}

int GetSliderValue(Int CurrentSlider)
{
    if(CurrentSlider<=-1)
    {
        CurrentSlider = ((CurrentSlider*27)/255)-1;
    }
    else if(CurrentSlider>=0)
    {
        CurrentSlider = ((CurrentSlider*27)/255)+1;
    }
    return CurrentSlider;
}