#include "..\..\..\lib/std.mi"

Global GuiObject InfolineLayer, InfolineText, InfolineTrigger, LeftMeter, RightMeter, LeftMeterPeak, RightMeterPeak, InfolineVUGUIOBJ;

Global int state;
Global float peak1, peak2, pgrav1, pgrav2, vu_falloffspeed;

Global timer VU;

System.onScriptLoaded(){

    Group currentgroup = getScriptGroup();
    Group infolinevu = currentgroup.findObject("infoline.vu");

    InfolineLayer = currentgroup.findObject("infoline.stuff");
    InfolineText = currentgroup.findObject("infoline.text");
    InfolineTrigger = currentgroup.findObject("infoline.trigger");
    InfolineVUGUIOBJ = currentgroup.findObject("infoline.vu");

    LeftMeter = infolinevu.findObject("leftbar");
    RightMeter = infolinevu.findObject("rightbar");
    LeftMeterPeak = infolinevu.findObject("leftpeak");
	RightMeterPeak = infolinevu.findObject("rightpeak");

    InfolineLayer.setTargetSpeed(1);
    InfolineText.setTargetSpeed(1);
    InfolineVUGUIOBJ.setTargetSpeed(1);

    pgrav1 = 0;
	pgrav2 = 0;

    VU = new Timer;
	VU.setdelay(16);
    VU.start();
    VU.onTimer();

    vu_falloffspeed = (2/100)+0.02;
}

InfolineTrigger.onLeftButtonDblClk(int x, int y){
    state++;

    if(state == 1){
        if(getStatus() == -1){
            InfolineLayer.setTargetY(0);
            InfolineText.setTargetY(0);
            InfolineVUGUIOBJ.setTargetY(0);
        }if(getStatus() == 0){
            InfolineLayer.setTargetY(-16);
            InfolineText.setTargetY(-16);
            InfolineVUGUIOBJ.setTargetY(-16);
        }if(getStatus() == 1){
            InfolineLayer.setTargetY(0);
            InfolineText.setTargetY(0);
            InfolineVUGUIOBJ.setTargetY(0);
        }
    }

    if(state >= 2){
        state = 0;
        InfolineLayer.setTargetY(-16);
        InfolineText.setTargetY(-16);
        InfolineVUGUIOBJ.setTargetY(-16);
    }
    
    InfolineLayer.setTargetSpeed(1);
    InfolineText.setTargetSpeed(1);
    InfolineVUGUIOBJ.setTargetSpeed(1);

    InfolineLayer.gotoTarget();
    InfolineText.gotoTarget();
    InfolineVUGUIOBJ.gotoTarget();
}

System.onStop(){
    if(state == 1){
        if(getStatus() == -1){
            InfolineLayer.setTargetY(0);
            InfolineText.setTargetY(0);
            InfolineVUGUIOBJ.setTargetY(0);
        }if(getStatus() == 0){
            InfolineLayer.setTargetY(-16);
            InfolineText.setTargetY(-16);
            InfolineVUGUIOBJ.setTargetY(-16);
        }if(getStatus() == 1){
            InfolineLayer.setTargetY(0);
            InfolineText.setTargetY(0);
            InfolineVUGUIOBJ.setTargetY(0);
        }
    }
    if(state == 0){
        InfolineLayer.setTargetY(-16);
        InfolineText.setTargetY(-16);
        InfolineVUGUIOBJ.setTargetY(-16);
    }
    
    InfolineLayer.setTargetSpeed(0.5);
    InfolineText.setTargetSpeed(0.5);
    InfolineVUGUIOBJ.setTargetSpeed(0.5);

    InfolineLayer.gotoTarget();
    InfolineText.gotoTarget();
    InfolineVUGUIOBJ.gotoTarget();
}

System.onPlay(){
    if(state == 1){
        if(getStatus() == -1){
            InfolineLayer.setTargetY(0);
            InfolineText.setTargetY(0);
            InfolineVUGUIOBJ.setTargetY(0);
        }if(getStatus() == 0){
            InfolineLayer.setTargetY(-16);
            InfolineText.setTargetY(-16);
            InfolineVUGUIOBJ.setTargetY(-16);
        }if(getStatus() == 1){
            InfolineLayer.setTargetY(0);
            InfolineText.setTargetY(0);
            InfolineVUGUIOBJ.setTargetY(0);
        }
    }
    if(state == 0){
        InfolineLayer.setTargetY(-16);
        InfolineText.setTargetY(-16);
        InfolineVUGUIOBJ.setTargetY(-16);
    }
    
    InfolineLayer.setTargetSpeed(0.5);
    InfolineText.setTargetSpeed(0.5);
    InfolineVUGUIOBJ.setTargetSpeed(0.5);

    InfolineLayer.gotoTarget();
    InfolineText.gotoTarget();
    InfolineVUGUIOBJ.gotoTarget();
}

System.onResume(){
    if(state == 1){
        if(getStatus() == -1){
            InfolineLayer.setTargetY(0);
            InfolineText.setTargetY(0);
            InfolineVUGUIOBJ.setTargetY(0);
        }if(getStatus() == 0){
            InfolineLayer.setTargetY(-16);
            InfolineText.setTargetY(-16);
            InfolineVUGUIOBJ.setTargetY(-16);
        }if(getStatus() == 1){
            InfolineLayer.setTargetY(0);
            InfolineText.setTargetY(0);
            InfolineVUGUIOBJ.setTargetY(0);
        }
    }
    if(state == 0){
        InfolineLayer.setTargetY(-16);
        InfolineText.setTargetY(-16);
        InfolineVUGUIOBJ.setTargetY(-16);
    }
    
    InfolineLayer.setTargetSpeed(0.5);
    InfolineText.setTargetSpeed(0.5);
    InfolineVUGUIOBJ.setTargetSpeed(0.5);

    InfolineLayer.gotoTarget();
    InfolineText.gotoTarget();
    InfolineVUGUIOBJ.gotoTarget();
}

System.onTitleChange(String newtitle){
    if(state == 1){
        if(getStatus() == -1){
            InfolineLayer.setTargetY(0);
            InfolineText.setTargetY(0);
            InfolineVUGUIOBJ.setTargetY(0);
        }if(getStatus() == 0){
            InfolineLayer.setTargetY(-16);
            InfolineText.setTargetY(-16);
            InfolineVUGUIOBJ.setTargetY(-16);
        }if(getStatus() == 1){
            InfolineLayer.setTargetY(0);
            InfolineText.setTargetY(0);
            InfolineVUGUIOBJ.setTargetY(0);
        }
    }
    if(state == 0){
        InfolineLayer.setTargetY(-16);
        InfolineText.setTargetY(-16);
        InfolineVUGUIOBJ.setTargetY(-16);
    }
    
    InfolineLayer.setTargetSpeed(0.5);
    InfolineText.setTargetSpeed(0.5);
    InfolineVUGUIOBJ.setTargetSpeed(0.5);

    InfolineLayer.gotoTarget();
    InfolineText.gotoTarget();
    InfolineVUGUIOBJ.gotoTarget();
}

VU.onTimer(){

    float level1 = getLeftVuMeter()/1.673202614379085;
    float level2 = getRightVuMeter()/1.673202614379085;


    LeftMeter.setXmlParam("w", integertostring(level1));
    RightMeter.setXmlParam("w", integertostring(level2));

    if (level1 >= peak1){
			peak1 = level1;
			pgrav1 = 0;
		}
		else{
			peak1 += pgrav1;
			pgrav1 -= vu_falloffspeed;
		}
		if (level2 >= peak2){
			peak2 = level2;
			pgrav2 = 0;
		}
		else{
			peak2 += pgrav2;
			pgrav2 -= vu_falloffspeed;
		}

    float peak1offset = peak1 + 4;
    float peak2offset = peak2 + 4;

    LeftMeterPeak.setXmlParam("x", integertostring(peak1offset));
    RightMeterPeak.setXmlParam("x", integertostring(peak2offset));
}