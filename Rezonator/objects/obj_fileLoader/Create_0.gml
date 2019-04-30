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

linesWithWordsList = ds_list_create();

participantsInCurrentDiscoList = ds_list_create();
hueOffset = 0;

fileLoadRate = 50;

ableToHotkey = true;

inititalAutosave = false;
initialAutosaveComplete = false;


importCSVCurrentUID = 0;
importCSVCurrentRow = 0;
importCSVWordIDList = ds_list_create();



loadingCSV = false;
//alarm[2] = 3600;