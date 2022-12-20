#include "compiler/lib/fileio.mi"
#include "compiler/lib/application.mi"

Function initDetector();

Global File myCheckerDoc, myCheckerDoc2;
Global boolean IsWACUP, IsPreview;
Global String wacuptest, wacuptest2;

initDetector(){

    myCheckerDoc = new File;
    myCheckerDoc2 = new File;
    wacuptest = (Application.GetSettingsPath()+"\\patreons.rtf"); //beta
    wacuptest2 = (Application.GetApplicationPath()+"\\Plugins\\gen_ml.dll"); //preview
    myCheckerDoc.load(wacuptest);
    myCheckerDoc2.load(wacuptest2);

    IsWACUP = myCheckerDoc.exists();
    IsPreview = myCheckerDoc2.exists();
}