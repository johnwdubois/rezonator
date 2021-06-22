//pickwhippedRow = -1;

show_debug_message("obj_importMapping Create STARTING... " + scr_printTime());

mouseoverRow = -1;

showDevVars = false;

//pickwhipColorNormal = c_blue;
//pickwhipColorRequired = c_red;

tagInfoGridSelectedRow = -1;

tagColorList = ds_list_create();
ds_list_add(tagColorList, c_red, c_blue, c_green, c_yellow, c_purple, c_olive, c_orange);
ds_list_add(tagColorList, c_teal, c_fuchsia, c_lime);

global.plainTextInfoGridWidth = 2;
global.plainTextInfoGrid_colText = 0;
global.plainTextInfoGrid_colGroup = 1;
global.plainTextInfoGrid = ds_grid_create(global.plainTextInfoGridWidth, 0);




mouseOverLevel = false;
inDropDown = false;
rowToChange = -1;
colToChange = -1;


if (global.importType == global.importType_PlainText || global.importType == global.importType_Paragraph) {	
	scr_importInfoGrid();
	room_goto(rm_loadingScreen);
}
else{
	instance_create_layer(0, 0, "InstancesDialogue", obj_importException);
}




//variables for keyboard
cursorPos = 1 ;
cursorViz = false;
inputText = "";
cursorTimer = 20;
global.givenSpeaker = "";


maxDisplaySize = 12;
canDelete = true;
canDeleteHoldingCounter = 0;
canPressLeft = true;
canPressLeftHoldingCounter = 0;
canPressRight = true;
canPressRightHoldingCounter = 0;
holdingLimit = 6;
loopItterations = 0;

canContinueAll = false;
canContinueDisplayToken = true;
canContinueUnit = true;
canContinueToken1to1 = false;
canContinueWordDelimiter = true;
canContinueWord1to1 = false;

if (global.importType != global.importType_CSV) {
	scr_checkTokenCount();
}

canPressMinus = true;
canPressPlus = true;

importGroupSchemaLoaded = false;

continueButtonClicked = false;

tokenRatio = 0.70;
currentTokenThreshold = 0;
currentWordThreshold = 0;
updatedErrorCol = false;
displayMarker = "";
wordDelimMarker = "";

levelEstimateColumnSelected = global.tagInfoGrid_colLevelSchema;

gridList = ds_list_create();
ds_list_add(gridList, "Field Info", "Import Source");

if(global.importType == global.importType_IGT){
ds_list_add(gridList,"Block Type", "Blocks", "Field Relations");

}
currentGridName = "Field Info";

alarm[5] = 2;

show_debug_message("obj_importMapping Create END... " + scr_printTime());