importedAudioFile = "";
if (global.project == "open") {
	show_debug_message("obj_fileLoader Create ... loading REZ");
	scr_loadREZ();
}
with (obj_control) {
	displayTokenList = ds_list_create();
	
	// by default, add the displayToken field and (if available) the transcription field
	scr_addToListOnce(displayTokenList, global.displayTokenField);
	if (is_string(global.tokenImportTranscriptColName) && global.tokenImportTranscriptColName != "") {
		scr_addToListOnce(displayTokenList, global.tokenImportTranscriptColName);
	}
	
	scr_deleteFromList(displayTokenList, "");
	
	displayTokenListIndex = 0;	
	
	// fill the wordform list up with up to 4 fields
	var displayTokenListSize = min(ds_list_size(global.tokenFieldList), 4);
	for (var i = 0; i < displayTokenListSize; i++) {
		scr_addToListOnce(displayTokenList, global.tokenFieldList[| i]);
	}
	
	// for plain files, use ~text field
	if (ds_list_size(displayTokenList) < 1) {
		ds_list_add(displayTokenList, "~text");
		global.displayTokenField = "~text";
	}
}


discourseProcessing = 0;
fileLineRipListElement = 0;


wordIDCounter = 0;
unitIDCounter = 0;







firstValidLineReached = false;
currentUnitID = -1;
currentUtteranceID = -1;
currentUnitpID = -1;
currentUnitParticipantName = "null";
currentUnitStart = -1;
currentUnitEnd = -1;
currentDiscoColor = ds_list_find_value(global.discoColorList, 0);
indexInDiscoColorList = 0;

linesWithWordsList = ds_list_create();

participantsInCurrentDiscoList = ds_list_create();
//hueOffset = 0;

fileLoadRate = 50;

ableToHotkey = true;

inititalAutosave = false;
//initialAutosaveComplete = false;


importCSVCurrentUID = 0;
importCSVCurrentRow = 0;
importCSVWordIDList = ds_list_create();

subLineGridBeginning = 0;
subLineGridEnd = 0;

//draw autosave text
drawAutosaveText = false;

loadingCSV = true;
if (ds_grid_height(global.importCSVGrid) > 0) {
	var importCSVGridHeight = ds_grid_height(global.importCSVGrid);
	ds_grid_resize(obj_control.wordGrid, global.wordGridWidth, importCSVGridHeight);
	ds_grid_resize(obj_control.dynamicWordGrid, global.dynamicWordGridWidth, importCSVGridHeight);
	ds_grid_resize(obj_control.wordDrawGrid, obj_control.wordDrawGridWidth, importCSVGridHeight);
	
	ds_grid_clear(obj_control.wordGrid, -1);
	ds_grid_clear(obj_control.dynamicWordGrid, -1);
	ds_grid_clear(obj_control.wordDrawGrid, -1);
}
currentRowWordGrid = 0;
currentRowUnitGrid = 0;
loadLineGridSectionCounter = 0;



global.importedSpecialFields = false;
global.unitTagMapFilled = false;
global.tokenTagMapFilled = false;
global.wordGridCopied = false;
global.unitGridCopied = false;
global.discoGridCopied = false;

// if this is prose/paragraph import, we will run the prose linebreak script
//if (global.importType == "import_type_prose") {
//}


show_debug_message("fileloader Create, navTokenFieldList: " + scr_getStringOfList(obj_control.navTokenFieldList));
// Used for auto-saving REZ's from CSVs
alarm[6] = 10;