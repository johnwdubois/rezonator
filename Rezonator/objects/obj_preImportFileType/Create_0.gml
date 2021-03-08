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
scrollBarHeight = 0;
scrollPlusY = 0;
scrollPlusYDest = 0;
scrollBarPlusY = 0;

importTypeMouseover = -1;

// set a default map for currentPreImportMap (this will be changed)
currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_PlainText);


importTypeSelected = global.importType_TabDelimited;