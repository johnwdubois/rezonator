function scr_importMappingGridsInit() {


	// initiate tokenImport
	global.tokenImportGridWidth = 4;
	global.tokenImport_colUnitID = 0;
	global.tokenImport_colTokenID = 1;
	global.tokenImport_colWordToken = 2;
	global.tokenImport_colWordTranscript = 3;
	global.tokenImportGrid = ds_grid_create(global.tokenImportGridWidth, 0);
	
	// initiate wordImport
	global.wordImportGridWidth = 2;
	global.wordImport_colUnitID = 0;
	global.wordImport_colWordID = 1;
	global.wordImportGrid = ds_grid_create(global.wordImportGridWidth, 0);

	// initiate unitImport
	global.unitImportGridWidth = 2;
	global.unitImport_colUnitID = 0;
	global.unitImport_colParticipant = 1;
	global.unitImportGrid = ds_grid_create(global.unitImportGridWidth, 0);

	// initiate discoImport
	global.discoImportGridWidth = 0;
	global.discoImportGrid = ds_grid_create(global.discoImportGridWidth, 0);






	// initiate customLabelGrid
	global.customLabelGridWidth = 3;
	global.customLabelGrid_colLevel = 0;
	global.customLabelGrid_colMarker = 1;
	global.customLabelGrid_colTagList = 2;
	global.customLabelGrid = ds_grid_create(global.customLabelGridWidth, 0);

	// initiate global variables for levels
	global.levelToken = "option_token";
	global.levelWord = "label_word";
	global.levelUnit = "tab_name_unit";
	global.levelDiscourse = "option_doc";
	global.levelUnknown = "tag_unknown";




}
