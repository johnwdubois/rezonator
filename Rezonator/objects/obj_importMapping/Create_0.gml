//pickwhippedRow = -1;

show_debug_message("obj_importMapping Create STARTING... " + scr_printTime());

mouseoverRow = -1;

showDevVars = false;

//pickwhipColorNormal = c_blue;
//pickwhipColorRequired = c_red;

rezInfoGridSelectedRow = -1;
tagInfoGridSelectedRow = -1;

tagColorList = ds_list_create();
ds_list_add(tagColorList, c_red, c_blue, c_green, c_yellow, c_purple, c_olive, c_orange);
ds_list_add(tagColorList, c_teal, c_fuchsia, c_lime);

global.plainTextInfoGridWidth = 2;
global.plainTextInfoGrid_colText = 0;
global.plainTextInfoGrid_colGroup = 1;
global.plainTextInfoGrid = ds_grid_create(global.plainTextInfoGridWidth, 0);



global.levelToken = 0;
global.levelUnit = 1;
global.levelDiscourse = 2;
global.levelUnknown = 3;



mouseOverLevel = false;
inDropDown = false;
rowToChange = -1;
colToChange = -1;


if (global.plainText) {	
	scr_importInfoGrid();
	instance_create_layer(0, 0, "InstancesDialogue", obj_importPlainTextInfo);
	room_goto(rm_mainScreen);
}
else{
	//instance_create_layer(0, 0, "InstancesDialogue", obj_importMappingRezInfo);
	//instance_create_layer(0, 0, "InstancesDialogue", obj_importMappingTagInfo);
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

canContinue = false;
canContinueToken = true;
canContinueUnit = true;
canContinueError = false;

if (global.importType != global.importType_CSV) {
	scr_checkTokenCount();
}

canPressMinus = true;
canPressPlus = true;

importGroupSchemaLoaded = false;

continueButtonClicked = false;

tokenRatio = 0.75;
currentTokenThreshold = 0;
updatedErrorCol = false;
displayMarker = "";



show_debug_message("obj_importMapping Create END... " + scr_printTime());