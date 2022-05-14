#include "..\..\..\lib/std.mi"

Global Group sliderGroup;
Global Slider myslider, myslider2;
Global Timer setSeekerImage;

//97,85,78, left
//176,172,170, right

System.onScriptLoaded() {
	sliderGroup = getScriptGroup();
    myslider = sliderGroup.findObject("volume");
    myslider2 = sliderGroup.findObject("balance");

    setSeekerImage = new Timer;
    setSeekerImage.setDelay(50);
    setSeekerImage.start();
}

setSeekerImage.onTimer(){
    if(myslider.getPosition() <= 78){
        myslider.setXmlParam("thumb", "eqshade.vol.seekl");
    }else{
        myslider.setXmlParam("thumb", "eqshade.vol.seekm");
    }
    if(myslider.getPosition() >= 170){
        myslider.setXmlParam("thumb", "eqshade.vol.seekr");
    }

    if(myslider2.getPosition() <= 78){
        myslider2.setXmlParam("thumb", "eqshade.bal.seekl");
    }else{
        myslider2.setXmlParam("thumb", "eqshade.bal.seekm");
    }
    if(myslider2.getPosition() >= 170){
        myslider2.setXmlParam("thumb", "eqshade.bal.seekr");
    }
}