//Feel free to steal and/or modify.
//If you're using this from the SimpleTutorial skin, do kindly give credit to
//"Eris Lund (0x5066)" or "0x5066", or don't! I don't mind.
//This is now updated that enables it to be included within the
//skin.xml, taken from Ariszló's updated oldtimer.maki script
//Updated to include a simple menu - 22.03.2021
//This disables the shade specific checks

//If you include this, make sure your text object
//has "display="time"" (and for TTF "forcefixed="1"")
//or else you won't get the fancy formatting the
//engine applies for song timers

#include "..\..\..\lib/std.mi"

Global String currentpos, strremainder, currentpos_rev, in_reverse;
Global GuiObject DisplayTime;
Global Timer timerSongTimer;
Global Timer timerSongTimerReverse;
Global int timermode;
Global int milliseconds;
Global int songlength;
Global int remainder;
Global int milliseconds_rev;
Global int i;

Global PopUpMenu clockMenu;

Function AreWePlaying();
Function InReverse();
Function TimeElapsedOrRemaining();
Function StaticTime();
Function StaticTimeRemainder();
Function endless();
Function endlesspaused();
Function notendless();
Function notendlesspaused();
Function notendlesspaused_rev();
Function stopped();
Function initplaytimer();
Function playing();
Function playing_rev();
Function ItsBeenMuchTooLong();

System.onScriptLoaded() 
{
    //Group mainshade = getContainer("main").getLayout("shade");
    /* Replace "timer" with "shade.time" for Winamp Classic Modern */
    //DisplayTimeShade = mainshade.findObject("timer");

    Group mainnormal = getScriptGroup();
    /* Replace "timer" with "display.time" for Winamp Classic Modern */
    DisplayTime = mainnormal.findObject("timer");
    //The above was taken from Ariszló's updated oldtimer.maki script
    //Allows it to be included in the skin.xml file of the skin

    //ints for playback
    milliseconds = System.getPosition();
    songlength = StringtoInteger(System.getPlayItemMetaDataString("length"));
    remainder = songlength - milliseconds;
    milliseconds_rev = milliseconds-songlength;

    //strings for playback
    currentpos = System.integerToTime(milliseconds);
    strremainder = System.integerToTime(remainder);
    currentpos_rev = System.integerToTime(milliseconds-songlength);

    timerSongTimer = new Timer;
	timerSongTimer.setDelay(50);
    timerSongTimerReverse = new Timer;
    timerSongTimerReverse.setDelay(50);

    initplaytimer();
}

//Here we run these checks every time a playback related action happens
//It's not enough to check on title change
System.onPlay(){
    timerSongTimer.start();
}

//We stop every timer and instead display Winamp Modern's default of "00:00"
System.onStop(){
    stopped();
}

StaticTime(){ //Needed since the timer has a delay of 50ms and we don't want any odd flashing on loading
    playing();
}


timerSongTimer.onTimer(){
    playing();
}

System.onResume(){
    timerSongTimer.start();
}

InReverse(){
//Just some sanity checks to ensure we're in the right modes
    songlength = StringtoInteger(System.getPlayItemMetaDataString("length"));
//In case of streams or VGM formats with endless playback
//We don't want the user to still be able to toggle
//between time remaining or elapsed, so we force
//the elapsed mode to run
//This has now been actually fixed
    //DisplayTimeShade.setXmlParam("tooltip", "Time Remaining (click to toggle elapsed)");

    if(songlength <= 0){
        if (getStatus() == -1){ //Paused
            endlesspaused();
        }
    else if (getStatus() == 0){ //Stopped
            stopped();
        }
	    else if (getStatus() == 1){ //Playing
            endless(); 
        }
    }
    else{
        if (getStatus() == -1){ //Paused
            notendlesspaused_rev();    
		}
    else if (getStatus() == 0){ //Stopped
            stopped();
		}
	else if (getStatus() == 1){ //Playing
            notendless();  
        }
    }
}

endless(){ //Playing for endless stuff
    StaticTime();
    timerSongTimer.start();
}

notendless(){ //Playing for non endless stuff
    timerSongTimer.stop();
}

endlesspaused(){ //Paused for endless stuff
    timerSongTimer.stop();
}

notendlesspaused(){ //Paused for non endless stuff
    timerSongTimer.stop();
}

notendlesspaused_rev(){ //Paused for non endless stuff, time remaining
    timerSongTimer.stop();
}

stopped(){
    songlength = StringtoInteger(System.getPlayItemMetaDataString("length"));
    timerSongTimer.stop();
    DisplayTime.setXmlParam("text", "Time: 00:00 / 00:00");
}

playing(){
    playing_rev();
    milliseconds = System.getPosition();
    currentpos = System.integerToTime(milliseconds);

    if(milliseconds < 600000){
        DisplayTime.setXmlParam("text", "Time: 0"+currentpos+" / "+in_reverse);
    }
    else{
        DisplayTime.setXmlParam("text", "Time: "+currentpos+" / "+in_reverse);
    }
    if(milliseconds > songlength){
        ItsBeenMuchTooLong();
        if(milliseconds < 600000){
            DisplayTime.setXmlParam("text", "Time: 0"+currentpos+" / "+in_reverse);
        }
        else{
            DisplayTime.setXmlParam("text", "Time: "+currentpos+" / "+in_reverse);
        }
    }
    if(songlength <= 0){
        ItsBeenMuchTooLong();
        if(milliseconds < 600000){
            DisplayTime.setXmlParam("text", "Time: 0"+currentpos+" / 00:00");
        }
        else{
            DisplayTime.setXmlParam("text", "Time: "+currentpos+" / 00:00");
        }
    }
}

playing_rev(){
    milliseconds = System.getPosition();
    songlength = StringtoInteger(System.getPlayItemMetaDataString("length"));
    remainder = songlength - milliseconds;
    milliseconds_rev = milliseconds-songlength;
    strremainder = System.integerToTime(remainder);
    currentpos_rev = System.integerToTime(milliseconds-songlength);

    if(remainder < 600000){
        in_reverse = "0"+strremainder;
    }
    else{
        in_reverse = ""+strremainder;
    }
}

initplaytimer(){
    StaticTime();
    timerSongTimer.start();   
}

ItsBeenMuchTooLong(){ //I feel it coming on, the feeling's gettin' strong
    milliseconds = System.getPosition();
    songlength = StringtoInteger(System.getPlayItemMetaDataString("length"));
    milliseconds_rev = milliseconds-songlength;

    if(milliseconds_rev < 600000){
        in_reverse = "0"+currentpos_rev;
    }
    else{
        in_reverse = currentpos_rev;
    }
}