/// @description Insert description here
// You can write your code in this editor
scr_scrollBarInit();

// create list to hold all the import types (so we can loop over them easily)
global.importTypeList = ds_list_create();
ds_list_add(global.importTypeList,
	global.importType_PlainText,
	global.importType_Paragraph,
	global.importType_CSV,
	global.importType_CoNLLU,
	global.importType_Transcription,
	global.importType_TabDelimited,
	global.importType_IGT);

scr_preImportInitiate();

importTypeMouseover = -1;

// set a default map for currentPreImportMap (this will be changed)
global.currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType);


importTypeSelected = global.importType_TabDelimited;