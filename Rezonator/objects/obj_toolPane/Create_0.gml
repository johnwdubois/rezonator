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



modeRead = 0;
modeRez = 1;
modeTrack = 2;
currentMode = modeRead;

setModeMain = modeRead;
setModeSearch = modeRead;


checkedForParticipantNames = false;



tracksOnlyStackShow = false;
rezOnlyStackShow = false;
newWordInFilter = false;


progressBarX = room_width - 100;
progressBarY = windowHeight + 72;
progressBarWidth = 100;
progressBarHeight = 32;
progressBarBackColor = c_gray;
progressBarFrontColor = c_blue;
progressBarFont = global.fontMain;

alarm[0] = 2;

hoverTime[0] = 0;
hoverTime[1] = 0;
hoverTime[2] = 0;
hoverTime[3] = 0;
ToolTipPosX = 0;
ToolTipPosY = 0;
hoverTimeLimit = 60;