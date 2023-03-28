/// @description Insert description here
// You can write your code in this editor
scr_scrollBarInit();

// create list to hold all the import types (so we can loop over them easily)
global.importTypeList = ds_list_create();
ds_list_add(global.importTypeList,
	IMPORTTYPE_TRANSCRIPTION,
	IMPORTTYPE_AICHAT,
	IMPORTTYPE_SONG,
	IMPORTTYPE_IGT,
	IMPORTTYPE_CONLLU,
	IMPORTTYPE_WORD,
	IMPORTTYPE_ELAN,
	IMPORTTYPE_PROSE
	);

scr_preImportInitiate();

importTypeMouseover = -1;

// set a default map for currentPreImportMap (this will be changed)
global.currentPreImportMap = global.preImportMap[? global.importType];


importTypeSelected = IMPORTTYPE_ELAN;