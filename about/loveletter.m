#include "..\..\..\lib/std.mi"

Global Text ALoveLetter;
Global timer Countdown;

Global int i;

System.onScriptLoaded(){

    group thisgroup = getScriptGroup();

    ALoveLetter = thisgroup.findObject("andcredits"); //can only fit 31 chars

    Countdown = new Timer;
    Countdown.setDelay(3000);
    Countdown.start();

    i = 0;
}

Countdown.onTimer(){
    i++;

    if(i == 1){
        ALoveLetter.setText("A love letter to the old times.");
    }
    if(i == 2){
        ALoveLetter.setText("");
    }
    if(i == 3){
        ALoveLetter.setText("Remembering the times, when...");
    }
    if(i == 4){
        ALoveLetter.setText("...customizing your system...");
    }
    if(i == 5){
        ALoveLetter.setText("made you really cool.");
    }
    if(i == 6){
        ALoveLetter.setText("");
    }
    if(i == 7){
        ALoveLetter.setText("A time when... companies...");
    }
    if(i == 8){
        ALoveLetter.setText("...wouldn't buy brands to...");
    }
    if(i == 9){
        ALoveLetter.setText("...destroy their reputation.");
    }
    if(i == 10){
        ALoveLetter.setText("");
    }
    if(i == 11){
        ALoveLetter.setText("");
    }
    if(i == 12){
        ALoveLetter.setText("Thank you to everyone who...");
    }
    if(i == 13){
        ALoveLetter.setText("...has been with me so far.");
    }
    if(i == 14){
        ALoveLetter.setText("You have no idea what it means");
    }
    if(i == 15){
        ALoveLetter.setText("...to me. (3");
    }
    if(i == 16){
        ALoveLetter.setText("");
    }
    if(i == 17){
        ALoveLetter.setText("Huge thank yous go to:");
    }
    if(i == 18){
        ALoveLetter.setText("DrO, Victhor, mirzi...");
    }
    if(i == 19){
        ALoveLetter.setText("...captbaritone, fathony...");
    }
    if(i == 20){
        ALoveLetter.setText("...Samey, ricola, and everyone");
    }
    if(i == 21){
        ALoveLetter.setText("... else who has been...");
    }
    if(i == 22){
        ALoveLetter.setText("...supporting me throughout.");
    }
    if(i == 23){
        ALoveLetter.setText("");
    }
    if(i == 24){
        ALoveLetter.setText("");
    }
    if(i == 25){
        i = 0;
    }
}