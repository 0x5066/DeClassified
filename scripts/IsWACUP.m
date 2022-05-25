#include "../../../lib/fileio.mi"
#include "../../../lib/application.mi"

Function initDetector();

Global File myCheckerDoc;
Global boolean IsWACUP;
Global String wacuptest;

initDetector(){

    myCheckerDoc = new File;
    wacuptest = (Application.GetSettingsPath()+"/patreons.rtf");
    myCheckerDoc.load (wacuptest);

    IsWACUP = myCheckerDoc.exists();
}