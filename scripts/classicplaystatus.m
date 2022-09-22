//Attempts to emulate to the best of it's abilities, the play symbol
//aka the green and red LED's found in the Classic Skins.
//Handles empty kbps and khz and streaming related things.

#include "songinfo.m"
#include "IsWACUP.m"

//Global Group player;
Global layer playstatus;
Global timer setPlaysymbol;

Function setState();
Function setState2();
Function initPlayLED();

Function DeleteStuff();
Function PauseStuff();
Function ResumeStuff();
Function PlayStuff();
Function ChangeTitle();
Function StopStuff();

initPlayLED(){

    initSongInfoGrabber();

    playstatus = MainWindow.findObject("playbackstatus");

    setPlaysymbol = new Timer;
    if(IsWACUP)
    {
        if(IsPreview){
            setPlaysymbol.setDelay(250); 
        }else{
            setPlaysymbol.setDelay(16);
        }
    }else{
        setPlaysymbol.setDelay(250); //because i still want to support 5.666 users, this is needed
    }
	
    setState();
    setState2();

    if(getStatus() == 1){
        playstatus.setXmlParam("alpha", "255");
    }else if(getStatus() == -1){
        playstatus.setXmlParam("alpha", "0");
    }else if(getStatus() == 0){
        playstatus.setXmlParam("alpha", "0");
        playstatus.setXmlParam("image", "wa.play.green");
    }
}

DeleteStuff(){
    deleteSongInfoGrabber();
}

PauseStuff(){
    //songInfoTimer.stop();

    playstatus.setXmlParam("alpha", "0");
}

ResumeStuff()
{
    String sit = getSongInfoText();
    String bitratestring = integerToString(bitrateint);
    String freqstring = integerToString(freqint);
	if (sit == "")
	{
		getSonginfo(sit);
		if(getStatus() == 1){
			bitrateint == 0;
			freqint == 0;
		}
	}if(sit != ""){
        getSonginfo(sit);
    }
	//songInfoTimer.start();
    setState2();

    //setPlaysymbol.start();
    playstatus.setXmlParam("alpha", "255");
    //messageBox(bitratestring, freqstring, 0, "");
}

PlayStuff()
{
    getSonginfo(getSongInfoText());
    String sit = getSongInfoText();
	if (sit == "")
	{
		getSonginfo(sit);
		if(getStatus() == 1){
			bitrateint == 0;
			freqint == 0;
		}
	}if(sit != ""){
        getSonginfo(sit);
    }
    setState2();

    //setPlaysymbol.start();
    playstatus.setXmlParam("alpha", "255");
}

ChangeTitle()
{
    String sit = getSongInfoText();
	if (sit == "")
	{
		getSonginfo(sit);
		if(getStatus() == 1){
			bitrateint == 0;
			freqint == 0;
		}
	}if(sit != ""){
        getSonginfo(sit);
    }
    setState2();

    if(getStatus() == 1){
        playstatus.setXmlParam("alpha", "255");
        //setPlaysymbol.start();
    }else if(getStatus() == -1){
        playstatus.setXmlParam("alpha", "0");
        setPlaysymbol.stop();
    }else if(getStatus() == 0){
        setPlaysymbol.stop();
        playstatus.setXmlParam("alpha", "0");
        playstatus.setXmlParam("image", "wa.play.green");
    }
}

StopStuff(){
    //songInfoTimer.stop();

    playstatus.setXmlParam("alpha", "0");
    playstatus.setXmlParam("image", "wa.play.green");
}

System.onInfoChange(String info){
	String sit = getSongInfoText();
    String bitratetxt = integerToString(bitrateint);
    String freqtxt = integerToString(freqint);
	if (sit == "")
	{
		getSonginfo(sit);
		if(getStatus() == 1){
			bitrateint == 0;
			freqint == 0;
		}
	}if(sit != ""){
        getSonginfo(sit);
    }
	setState2();
}

setPlaysymbol.onTimer()
{
    String sit = getSongInfoText();
    if (sit == "")
	{
		getSonginfo(sit);
		if(getStatus() == 1){
			bitrateint == 0;
			freqint == 0;
		}
	}if(sit != ""){
        getSonginfo(sit);
    }
	setState2();
    setState2();
}

setState(){
    String currenttitle = System.strlower(System.getPlayItemDisplayTitle());
    
    if(System.strsearch(currenttitle, "[connecting") != -1){
		playstatus.setXmlParam("image", "wa.play.red");
	}
    if(System.strsearch(currenttitle, "[resolving hostname") != -1){
		playstatus.setXmlParam("image", "wa.play.red");
	}
    if(System.strsearch(currenttitle, "[http/1.1") != -1){
		playstatus.setXmlParam("image", "wa.play.red");
	}
    if(System.strsearch(currenttitle, "[buffer") != -1){
		playstatus.setXmlParam("image", "wa.play.red");
	}else{
        if(bitrateint == 0 || bitrateint == -1 && freqint == 0 || freqint == -1){
            playstatus.setXmlParam("image", "wa.play.red"); 
            setPlaysymbol.start();
        }
        if(bitrateint > 0 && freqint > 0){setPlaysymbol.start(); 
            playstatus.setXmlParam("image", "wa.play.green");
        }
    }
}

//surely there's ways to improve how this is handled
setState2(){
    if(!WA5MODE){
        if(getPosition() < getPlayItemLength()-1093){ //1093 was eyeballed
            playstatus.setXmlParam("image", "wa.play.green");
            setState();
        }else if(getPlayItemLength() <= 0){
            playstatus.setXmlParam("image", "wa.play.green");
            setState();
        }else{
            playstatus.setXmlParam("image", "wa.play.red"); //only ever occurs if the above conditions passed
        }
    }else{
        if(getPlayItemLength() <= 0 && bitrateint == 0 || bitrateint == -1 && freqint == 0 || freqint == -1){
            playstatus.setXmlParam("image", "wa.play.red"); //has to appear first, i think i'm getting the logic wrong...
        }else{
            playstatus.setXmlParam("image", "wa.play.green");
            setState();
        }
    }
}