#include "..\..\..\lib/std.mi"

Global text channel;
Global timer getchanneltimer;
Global int c;
Global String channelState;

Function int getChannels();

System.onScriptLoaded(){

    Group player = getScriptGroup();

    channel = player.findObject("channel");

    getchanneltimer = new Timer;
	getchanneltimer.setDelay(250);

    c = getChannels();

    if(c == 2){
        channel.setXmlParam("text", "Channel: Stereo");
    }else if(c == 1){
        channel.setXmlParam("text", "Channel: Mono");
    }else if(c == -1){
        channel.setXmlParam("text", "Channel: Surround");
    }
}

System.onResume()
{
	getchanneltimer.start();
}

System.onPlay()
{
	getchanneltimer.start();
    c = getChannels();
    if(c == 2){
        channel.setXmlParam("text", "Channel: Stereo");
    }else if(c == 1){
        channel.setXmlParam("text", "Channel: Mono");
    }else if(c == -1){
        channel.setXmlParam("text", "Channel: Surround");
    }
}

System.onTitleChange(String newtitle)
{
	getchanneltimer.start();
    c = getChannels();
    if(c == 2){
        channel.setXmlParam("text", "Channel: Stereo");
    }else if(c == 1){
        channel.setXmlParam("text", "Channel: Mono");
    }else if(c == -1){
        channel.setXmlParam("text", "Channel: Surround");
    }
}

System.onStop(){
    getchanneltimer.stop();
    channel.setXmlParam("text", "Channel: ");
}

getchanneltimer.onTimer ()
{
    c = getChannels();
    if(c == 2){
        channel.setXmlParam("text", "Channel: Stereo");
    }else if(c == 1){
        channel.setXmlParam("text", "Channel: Mono");
    }else if(c == -1){
        channel.setXmlParam("text", "Channel: Surround");
    }
}

Int getChannels()
{
	if (strsearch(getSongInfoText(), "tereo") != -1)
	{
		return 2;
	}
	else if (strsearch(getSongInfoText(), "ono") != -1)
	{
		return 1;
	}
	else if (strsearch(getSongInfoText(), "annels") != -1)
	{
		int pos = strsearch(getSongInfoText(), "annels");
		return stringToInteger(strmid(getSongInfoText(), pos - 4, 1));
	}
	else
	{
		return -1;
	}
}