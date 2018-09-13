global.fileLineRipList = ds_list_create();

global.fileLineRipGripWidth = 5;
global.fileLineRipGrid_colDiscoID = 0;
global.fileLineRipGrid_colFileLineRipList = 1;
global.fileLineRipGrid_colUnitAmount = 2;
global.fileLineRipGrid_colParticipantList = 3;
global.fileLineRipGrid_colColorList = 4;
global.fileLineRipGrid = ds_grid_create(global.fileLineRipGripWidth, 0);

global.totalUnitAmount = 0;

global.participantColorList = ds_list_create();

global.wordGridWidth = 5;
global.dynamicWordGridWidth = 8;
global.unitGridWidth = 9;

global.openProject = false;
global.newProject = false;

wordAmountList = ds_list_create();

lineTotal = 0;
wordTotal = 0;
wordsToLoad = 0;

windowWidth = (room_width * 0.6);
windowHeight = (room_height * 0.6);
windowX1 = (room_width * 0.2);
windowY1 = (room_height * 0.4) - 20;
windowX2 = windowX1 + windowWidth;
windowY2 = windowY1 + windowHeight;


importWindowWidth = room_width / 2;
importWindowHeight = room_height / 5;
importWindowX1 = room_width * 0.25;
importWindowY1 = room_height * 0.4;
importWindowX2 = importWindowX1 + importWindowWidth;
importWindowY2 = importWindowY1 + importWindowHeight;

scrollBarHolding = false;
scrollBarHoldingPlusY = 0;
currentTopViewRow = 0;
scrollRange = 6;

//scr_openXML();

//room_goto_next();

canContinue = false;

participantHueOffset = 0;