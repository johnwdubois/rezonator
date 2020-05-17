//pickwhippedRow = -1;

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

global.tagInfoGridWidth = 7;
global.tagInfoGrid_colMarker = 0;
global.tagInfoGrid_colExample = 1;
global.tagInfoGrid_colLevel = 2;
global.tagInfoGrid_colMarkerPercent = 3;
global.tagInfoGrid_colSingleTokenMarker = 4;
global.tagInfoGrid_colDisplayToken = 5;
global.tagInfoGrid_colDisplayUnit = 6;

global.tagInfoGrid = ds_grid_create(global.tagInfoGridWidth, 0);


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