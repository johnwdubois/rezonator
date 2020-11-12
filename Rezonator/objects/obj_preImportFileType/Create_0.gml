clipSurface = -1;
clipWidth = 100;
clipHeight = 100;
clipX = 0;
clipY = 0;
windowResizeXHolding = false;
windowResizeYHolding = false;
windowX = 0;
windowY = 0;

// scrollbar variables
scrollBarHolding = false;
scrollBarUpButtonHeld = false;
scrollBarDownButtonHeld = false;
global.scrollBarWidth = 20;
scrollBarHeight = 0;
scrollPlusY = 0;
scrollPlusYDest = 0;
scrollBarPlusY = 0;

// set a default map for currentPreImportMap (this will be changed)
currentPreImportMap = ds_map_find_value(global.preImportMap, "Plain text");


importTypeSelected = global.importType_PlainText;
displayImportTypeList = ds_list_create();
ds_list_add(displayImportTypeList, global.importType_PlainText,
	global.importType_TabDelimited,
	global.importType_IGT,
	global.importType_CSV,
	global.importType_CoNLLU);