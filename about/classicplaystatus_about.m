//Attempts to emulate to the best of it's abilities, the play symbol
//aka the green and red LED's found in the Classic Skins.
//Handles empty kbps and khz and streaming related things.

#include "..\..\..\lib/std.mi"
#include "..\scripts\songinfo.m"

Global Group player;
Global GuiObject playstatus;
Global timer setPlaysymbol;

Global String PLAYING;
Global String initText;

Function setState();
Function setState2();

System.onScriptLoaded(){

    initSongInfoGrabber();
    initText = "Playback Status: ";

    Group player = getScriptGroup();

    playstatus = player.findObject("status");

    setPlaysymbol = new Timer;
	setPlaysymbol.setDelay(250);

    setState();
    setState2();

    if(getStatus() == 1){
        PLAYING = initText+"Playing";
        playstatus.setXmlParam("text", PLAYING);
    }else if(getStatus() == -1){
        PLAYING = initText+"Paused";
        playstatus.setXmlParam("text", PLAYING);
    }else if(getStatus() == 0){
        PLAYING = initText+"Stopped";
        playstatus.setXmlParam("text", PLAYING);
    }
}

System.onScriptUnloading(){
    deleteSongInfoGrabber();
}

System.onPause(){
    songInfoTimer.stop();

    PLAYING = initText+"Paused";
    playstatus.setXmlParam("text", PLAYING);
}

System.onResume()
{
    String sit = getSongInfoText();
    String bitratestring = integerToString(bitrateint);
    String freqstring = integerToString(freqint);
	if (sit != "") getSonginfo(sit);
	else songInfoTimer.setDelay(250); // goes to 250ms once info is available
	songInfoTimer.start();
    setState2();
    PLAYING = initText+"Playing";

    //setPlaysymbol.start();
    //messageBox(bitratestring, freqstring, 0, "");
}

System.onPlay()
{
    String sit = getSongInfoText();
	if (sit != "") getSonginfo(sit);
	else songInfoTimer.setDelay(250); // goes to 250ms once info is available
	songInfoTimer.start();
    setState2();

    //setPlaysymbol.start();
}

System.onTitleChange(String newtitle)
{
    String sit = getSongInfoText();
	if (sit != "") getSonginfo(sit);
	else songInfoTimer.setDelay(250); // goes to 250ms once info is available
	songInfoTimer.start();
    setState2();

    if(getStatus() == 1){
        PLAYING = initText+"Playing";
        playstatus.setXmlParam("text", PLAYING);
        //setPlaysymbol.start();
    }else if(getStatus() == -1){
        PLAYING = initText+"Paused";
        playstatus.setXmlParam("text", PLAYING);
        setPlaysymbol.stop();
    }else if(getStatus() == 0){
        setPlaysymbol.stop();
        PLAYING = initText+"Stopped";
        playstatus.setXmlParam("text", PLAYING);
    }
}

System.onStop(){
    songInfoTimer.stop();

    PLAYING = initText+"Stopped";
    playstatus.setXmlParam("text", PLAYING);
}

songInfoTimer.onTimer(){
	String sit = getSongInfoText();
	if (sit == "") return;
	songInfoTimer.setDelay(250);
	getSonginfo(sit);
	setState2();
}

setPlaysymbol.onTimer()
{
    setState2();
}

setState(){
    String currenttitle = System.strlower(System.getPlayItemDisplayTitle());
    
    if(System.strsearch(currenttitle, "[connecting") != -1){
		PLAYING = initText+"Connecting to stream...";
        playstatus.setXmlParam("text", PLAYING);
	}
    if(System.strsearch(currenttitle, "[resolving hostname") != -1){
		PLAYING = initText+"Resolving hostname...";
        playstatus.setXmlParam("text", PLAYING);
	}
    if(System.strsearch(currenttitle, "[http/1.1") != -1){
		PLAYING = initText+"200 OK";
        playstatus.setXmlParam("text", PLAYING);
	}
    if(System.strsearch(currenttitle, "[buffer") != -1){
		PLAYING = initText+"Buffering...";
        playstatus.setXmlParam("text", PLAYING);
	}else{
        if(bitrateint == 0 || bitrateint == -1 && freqint == 0 || freqint == -1){
            //PLAYING = initText+"No data!";
            playstatus.setXmlParam("text", PLAYING);
            setPlaysymbol.start();
        }
        if(bitrateint > 0 && freqint > 0){setPlaysymbol.start(); 
            //PLAYING = initText+"Data available!";
            playstatus.setXmlParam("text", PLAYING);
        }
    }
}

setState2(){
    if(getPosition() < getPlayItemLength()-1093){ //1093 was eyeballed
        if(getStatus() == -1){
            PLAYING = initText+"Paused";
            playstatus.setXmlParam("text", PLAYING);
        }
        if(getStatus() == 1){
            PLAYING = initText+"Playing";
            playstatus.setXmlParam("text", PLAYING);
        }
        setState();
    }else if(getPlayItemLength() <= 0){
        if(getStatus() == 0){
            PLAYING = initText+"Stopped";
            playstatus.setXmlParam("text", PLAYING);
        }
        if(getStatus() == 1){
            PLAYING = initText+"Streaming";
            playstatus.setXmlParam("text", PLAYING);
        }
        setState();
    }else{
        if(getStatus() == -1){
            PLAYING = initText+"Paused";
            playstatus.setXmlParam("text", PLAYING);
        }
        if(getStatus() == 1){
            PLAYING = initText+"About to end";
            playstatus.setXmlParam("text", PLAYING);
        }
    }
}