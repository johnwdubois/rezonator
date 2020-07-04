/*
	obj_fileLoader: Create
	
	Last Updated: 2019-02-11
	
	Called from: The creation of a fileLoader object
	
	Purpose: Instantiate all variables used by fileLoader objects
	
	Mechanism: variable creation and assignment
	
	Author: Terry DuBois
*/

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
if (ds_grid_height(global.importCSVGrid) > 0) {
	//importCSVCurrentUID = real(ds_grid_get(global.importCSVGrid, global.importCSVGrid_colUID, 0));
}

subLineGridBeginning = 0;
subLineGridEnd = 0;

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

//alarm[2] = 3600;