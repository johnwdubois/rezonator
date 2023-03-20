/// @description Insert description here
// You can write your code in this editor
scr_scrollBarInit();

// create list to hold all the import types (so we can loop over them easily)
global.importTypeList = ds_list_create();
ds_list_add(global.importTypeList,
	"import_type_transcription",
	"import_type_aichat",
	"import_type_song",
	"import_type_interlinear",
	"import_type_conllu",
	"import_type_word",
	"import_type_elan",
	"import_type_prose"
	);

scr_preImportInitiate();

importTypeMouseover = -1;

// set a default map for currentPreImportMap (this will be changed)
global.currentPreImportMap = global.preImportMap[? global.importType];


importTypeSelected = "import_type_elan";