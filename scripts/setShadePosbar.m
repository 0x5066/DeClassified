#include "..\..\..\lib/std.mi"

Global Group sliderGroup;
Global Slider myslider;
Global Timer setSeekerImage;

//97,85,78, left
//176,172,170, right

System.onScriptLoaded() {
	sliderGroup = getScriptGroup();
    myslider = sliderGroup.findObject("seeker");

    setSeekerImage = new Timer;
    setSeekerImage.setDelay(50);
    setSeekerImage.start();
}

setSeekerImage.onTimer(){
    if(myslider.getPosition() <= 78){
        myslider.setXmlParam("thumb", "posbarsl");
    }else{
        myslider.setXmlParam("thumb", "posbarsm");
    }
    if(myslider.getPosition() >= 170){
        myslider.setXmlParam("thumb", "posbarsr");
    }
}