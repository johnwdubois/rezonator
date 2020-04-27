//pickwhippedRow = -1;

showDevVars = false;

//pickwhipColorNormal = c_blue;
//pickwhipColorRequired = c_red;

continueButtonActive = false;

rezInfoGridSelectedRow = -1;
tagInfoGridSelectedRow = -1;

tagColorList = ds_list_create();
ds_list_add(tagColorList, c_red, c_blue, c_green, c_yellow, c_purple, c_olive, c_orange);
ds_list_add(tagColorList, c_teal, c_fuchsia, c_lime);

global.plainTextInfoGridWidth = 2;
global.plainTextInfoGrid_colText = 0;
global.plainTextInfoGrid_colGroup = 1;
global.plainTextInfoGrid = ds_grid_create(global.plainTextInfoGridWidth, 0);


tagInfoGridWidth = 8;
tagInfoGrid_colLabel = 0;
tagInfoGrid_colExample = 1;
tagInfoGrid_colLevelEstimation = 2;
tagInfoGrid_colConsistency = 3;
tagInfoGrid_colGroup = 4;
tagInfoGrid_colOneTokenPerGroup = 5;
tagInfoGrid_colMapped = 6;
tagInfoGrid_colColor = 7;
tagInfoGrid = ds_grid_create(tagInfoGridWidth, 0);


if (global.plainText) {	
	scr_importInfoGrid();
	instance_create(0, 0, obj_importPlainTextInfo);
	room_goto(rm_mainScreen);
}
else{
	//instance_create(0, 0, obj_importMappingRezInfo);
	//instance_create(0, 0, obj_importMappingTagInfo);
	instance_create(0, 0, obj_importException);
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



//scr_importMappingGroups();