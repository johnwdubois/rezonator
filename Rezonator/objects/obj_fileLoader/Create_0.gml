if (global.openProject) {
	show_debug_message("obj_loadingControl Create ... loading REZ");
	scr_loadREZ();
}
with(obj_control){
	displayTokenList = ds_list_create();
	
	//Look for where global.displayTokenField changes in order to interact with this list
	ds_list_add(displayTokenList, global.displayTokenField);
	displayTokenListIndex = 0;	
	
	for(var i = 0; i < 3 and i < ds_list_size(global.tokenFieldList); i++){
		scr_addToListOnce(displayTokenList, global.tokenFieldList[| i]);
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
if (global.importType == global.importType_Paragraph) {
	with (obj_alarm2) {
		alarm[0] = 3;
	}
}



// Used for auto-saving REZ's from CSVs
alarm[6] = 10;

show_debug_message("obj_fileLoader create end");
instance_destroy();