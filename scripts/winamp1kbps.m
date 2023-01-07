//Taken from Winamp Modern, does not come with the channels
//handling, as that is done inside monoster.m

#include "..\..\..\lib/std.mi"
#include "IsWACUP.m"

Function string tokenizeSongInfo(String tkn, String sinfo);
Function getSonginfo(String SongInfoString);

Global Group player;
Global Text bitrateText, FrequencyText;
//Global Timer songInfoTimer;
Global String SongInfoString, freqstring, bitratestring;
Global int bitrateint, freqint;
Global AlbumArtLayer waaa;

System.onScriptLoaded(){
	initDetector();

	player = getScriptGroup();

	bitrateText = player.findObject("bitrate");
	frequencyText = player.findObject("mixrate");

	//songInfoTimer = new Timer;
	//songInfoTimer.setDelay(250);

	if (getStatus() == STATUS_PLAYING) {
		String sit = getSongInfoText();
		if (sit != "") getSonginfo(sit);
		//else songInfoTimer.setDelay(250); // goes to 250ms once info is available
		//songInfoTimer.start();
	} else if (getStatus() == STATUS_PAUSED) {
		getSonginfo(getSongInfoText());
	}
}

System.onScriptUnloading(){
	//delete songInfoTimer;
}

System.onPlay(){
	String sit = getSongInfoText();
	if (sit != "") getSonginfo(sit);
	//else songInfoTimer.setDelay(250); // goes to 250ms once info is available
	//songInfoTimer.start();
	getSonginfo(getSongInfoText());
}

System.onTitleChange(String newtitle){
	String sit = getSongInfoText();
	if (sit == "")
	{
		getSonginfo(sit);
		if(getStatus() == 1){
			if(IsWACUP){
				bitrateText.setText(" --");
				frequencyText.setText("--");
			}else if(IsWACUP && IsPreview){
				bitrateText.setText("  0");
				frequencyText.setText(" 0");
			}else{
				bitrateText.setText("  0");
				frequencyText.setText(" 0");
			}
		}
	}
	//else songInfoTimer.setDelay(250); // goes to 250ms once info is available
	//songInfoTimer.start();
}

System.onStop(){
	//songInfoTimer.stop();
	frequencyText.setText("");
	bitrateText.setText("");
}

System.onResume(){
	String sit = getSongInfoText();
	if (sit != "") getSonginfo(sit);
	//else songInfoTimer.setDelay(250); // goes to 250ms once info is available
	//songInfoTimer.start();
}

System.onPause(){
	//songInfoTimer.stop();
}

System.onInfoChange(String info){
	String sit = getSongInfoText();
	if (sit == "")
	{
		getSonginfo(sit);
		if(getStatus() == 1){
			if(IsWACUP){
				bitrateText.setText(" --");
				frequencyText.setText("--");
			}else if(IsWACUP && IsPreview){
				bitrateText.setText("  0");
				frequencyText.setText(" 0");
			}else{
				bitrateText.setText("  0");
				frequencyText.setText(" 0");
			}
		}
	}
	//songInfoTimer.setDelay(250);
	getSonginfo(sit);
}

String tokenizeSongInfo(String tkn, String sinfo){
	int searchResult;
	String rtn;
	if (tkn=="Bitrate"){
		for (int i = 0; i < 5; i++) {
			rtn = getToken(sinfo, " ", i);
			searchResult = strsearch(rtn, "kbps");
			if (searchResult>0) return StrMid(rtn, 0, searchResult);
		}
		return "";
	}

	if (tkn=="Frequency"){
		for (int i = 0; i < 5; i++) {
			rtn = getToken(sinfo, " ", i);
			searchResult = strsearch(strlower(rtn), "khz");
			if (searchResult>0) {
				String r = StrMid(rtn, 0, searchResult);
				int dot = StrSearch(r, ".");
				if (dot == -1) dot = StrSearch(r, ",");
				if (dot != -1) return StrMid(r, 0, dot);
				return r;
			}

		}
		return "";
	}
	else return "";
}

getSonginfo(String SongInfoString) {
	String tkn;

	tkn = tokenizeSongInfo("Bitrate", SongInfoString);
	bitrateint = System.Stringtointeger(tkn);
	bitratestring = System.IntegerToString(bitrateint);
	if(tkn != "") {bitrateText.setText(tkn);}
	if(bitrateint < 100) {bitrateText.setText(" "+tkn);}
	if(bitrateint < 10) {bitrateText.setText("  "+tkn);}
	if(bitrateint > 1000) {bitrateText.setText(strleft(tkn, 2)+"H");} //definitely hundred
	if(bitrateint > 10000) {bitrateText.setText(strleft(tkn, 1)+"C");} //still not sure about this - Cillions???
	if(bitrateint > 10000 && strlen(strleft(tkn, 1)+"C") == 2) {bitrateText.setText(" "+strleft(tkn, 1)+"C");} //has to exist because i wasnt accounting for extremely high bitrates
	if(IsWACUP){
		if(bitrateint == 0 || bitrateint == -1) {bitrateText.setText(" --");}
	}else if(IsWACUP && IsPreview){
		if(bitrateint == 0 || bitrateint == -1) {bitrateText.setText("  0");}
	}else{
		if(bitrateint == 0 || bitrateint == -1) {bitrateText.setText("  0");}
	}


	tkn = tokenizeSongInfo("Channels", SongInfoString);
	tkn = tokenizeSongInfo("Frequency", SongInfoString);
	freqint = System.Stringtointeger(tkn);
	freqstring = System.IntegerToString(freqint);
	if(tkn != "") {frequencyText.setText(tkn);}
	if(freqint < 100) {frequencyText.setText(tkn);}
	if(freqint < 10) {frequencyText.setText(" "+tkn);}
	if(IsWACUP){
		if(freqint == 0 || freqint == -1 ) {frequencyText.setText("--");}
	}else if(IsWACUP && IsPreview){
		if(freqint == 0 || freqint == -1 ) {frequencyText.setText(" 0");}
	}else{
		if(freqint == 0 || freqint == -1 ) {frequencyText.setText(" 0");}
	}
	
	if(IsWACUP == 1){
		if(freqint > 100) {frequencyText.setText(strleft(tkn, 1)+"H");} //definitely hundred
		if(freqint > 10000) {frequencyText.setText(strleft(tkn, 1)+"C");} //still not sure about this - Cillions???
	}else{
		if(freqint < 100) {frequencyText.setText(tkn);}
		if(freqint > 100) {frequencyText.setText(strright(tkn, 2));}
	}


	if(getStatus() == 0){
		bitrateText.setText("   ");
		frequencyText.setText("  ");
	}
}

bitratetext.onEnterArea(){
	if(IsWACUP == 1){
		bitratetext.setXmlParam("tooltip", "Current bitrate: "+bitratestring+" kbps");
	}
}

frequencyText.onEnterArea(){
	if(IsWACUP == 1){
		frequencyText.setXmlParam("tooltip", "Current samplerate: "+freqstring+" khz");
	}
}