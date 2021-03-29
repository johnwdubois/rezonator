/*
	Purpose: Instantiate all variables used by the toolPane object
*/

global.toolPaneWidth = 300;
windowWidth = global.toolPaneWidth;
windowHeight = 170;

originalWindowHeight = 20;
showTool = true;

x = room_width - windowWidth;
y = originalWindowHeight;

toolAmount = 5;
toolPointer = 0;
toolRezBrush = 1;
toolTrackBrush = 2;
toolStackBrush = 3;
toolNewWord = 4;
toolBoxBrush = 5; // toolBoxBrush??
toolPlaceChains = 6;

currentTool = toolRezBrush;

tempReturnTool = -1;

toolSpriteScale = 1;


modeRead = 0;
modeRez = 1;
modeTrack = 2;
currentMode = modeTrack;

setModeMain = modeRead;
setModeSearch = modeRead;


checkedForParticipantNames = false;


newWordInFilter = false;


alarm[0] = 2;

hoverTime[0] = 0;
hoverTime[1] = 0;
hoverTime[2] = 0;
hoverTime[3] = 0;
ToolTipPosX = 0;
ToolTipPosY = 0;
hoverTimeLimit = 60;

mouseOverToolPane = false;