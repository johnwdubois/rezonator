/*
	obj_openingScreen: Create
	
	Last Updated: 2019-02-11
	
	Called from: The creation of the openingScreen object
	
	Purpose: Instantiate all variables used by the openingScreen object
	
	Mechanism: variable creation and assignment
	
	Author: Terry DuBois
*/



window_set_cursor(cr_default);

scr_colorThemeGridInit();

 
global.toolPaneWidth = 100;

global.versionString = string(game_display_name);
global.versionString = string_delete(global.versionString, 1, string_length("Rezonator"));
global.versionString = "Version" + global.versionString;



global.fileLineRipList = ds_list_create();

global.fileLineRipGripWidth = 7;
global.fileLineRipGrid_colDiscoID = 0;
global.fileLineRipGrid_colFileLineRipList = 1;
global.fileLineRipGrid_colUnitAmount = 2;
global.fileLineRipGrid_colParticipantList = 3;
global.fileLineRipGrid_colColorList = 4;
global.fileLineRipGrid_colParticipantIDList = 5;
global.fileLineRipGrid = ds_grid_create(global.fileLineRipGripWidth, 0);

global.totalUnitAmount = 0;

global.participantColorList = ds_list_create();

global.wordGridWidth = 7;
global.dynamicWordGridWidth = 17;
global.unitGridWidth = 10;

global.openProject = false;
global.newProject = false;
global.menuOpen = true;
global.neworOpen = false;
global.tutorial = false;
global.games = false;
//global.inRezzles = false;



global.importType_Default = 0;
global.importType_CSV = "One Word per Line";
global.importType_CoNLLU = "CoNLL-U";
global.importType_IGT = "Interlinear Glossed Text";
global.importType_PlainText = "Song & Verse";
global.importType_TabDelimited = "Elan (tab-delimited)";
global.importType = global.importType_PlainText;

// create list to hold all the import types (so we can loop over them easily)
global.importTypeList = ds_list_create();
ds_list_add(global.importTypeList, global.importType_PlainText,
	global.importType_TabDelimited,
	global.importType_IGT,
	global.importType_CSV,
	global.importType_CoNLLU);



global.plainText = false;
global.tabDeliniatedText = false;

global.fileSaveName = "undefined";
global.stackGrabSave = false;

global.importGridColNameList = ds_list_create();
global.tokenImportColNameList = ds_list_create();
global.wordImportColNameList = ds_list_create();
global.unitImportColNameList = ds_list_create();
global.discoImportColNameList = ds_list_create();

ds_list_clear(global.tokenImportColNameList);
ds_list_clear(global.unitImportColNameList);
ds_list_clear(global.discoImportColNameList);

global.tokenImportTagMap = ds_map_create();
global.unitImportTagMap  = ds_map_create();
global.stackTagMap = ds_map_create();

// stack tags hard-coded in map for now...
var actTagList = ds_list_create();
var repairTagList = ds_list_create();
var actSequenceTagList = ds_list_create();
ds_list_add(actTagList, "Question", "Answer");
ds_list_add(repairTagList, "Break", "Edit", "Fix");
ds_list_add(actSequenceTagList, "Q&A", "Repair");
ds_map_add_list(global.stackTagMap, "act", actTagList);
ds_map_add_list(global.stackTagMap, "repair", repairTagList);
ds_map_add_list(global.stackTagMap, "act sequence", actSequenceTagList);







global.discoColorList = ds_list_create();
ds_list_add(global.discoColorList, make_color_rgb(183, 183, 255)); // blue
ds_list_add(global.discoColorList, make_color_rgb(255, 184, 255)); // purple
ds_list_add(global.discoColorList, make_color_rgb(255, 209, 184)); // orange
ds_list_add(global.discoColorList, make_color_rgb(255, 250, 184)); // yellow
ds_list_add(global.discoColorList, make_color_rgb(195, 255, 184)); // green


wordAmountList = ds_list_create();

lineTotal = 0;
wordTotal = 0;
//wordsToLoad = 0;

windowWidth = (room_width * 0.6);
windowHeight = (room_height * 0.6);
windowX1 = (room_width * 0.2);
windowY1 = (room_height * 0.4) - 20;
windowX2 = windowX1 + windowWidth;
windowY2 = windowY1 + windowHeight;


importWindowWidth = camera_get_view_width(view_camera[0]) / 2;
importWindowHeight = camera_get_view_height(view_camera[0]) / 5;
importWindowX1 = camera_get_view_width(view_camera[0]) * 0.25;
importWindowY1 = camera_get_view_height(view_camera[0]) * 0.4;
importWindowX2 = importWindowX1 + importWindowWidth;
importWindowY2 = importWindowY1 + importWindowHeight;

scrollBarHolding = false;
scrollBarHoldingPlusY = 0;
currentTopViewRow = 0;
scrollRange = 6;

clickedIn = false;

//scr_openXML();

//room_goto_next();

canContinue = false;

participantHueOffset = 0;

showDevVars = false;

scr_importPackage();


global.currentDirString = global.rezonatorDirString;

global.rememberMe = false;

global.importCSVGrid = ds_grid_create(0, 0);
global.importCSVGrid_colIndex = 1;
global.importCSVGrid_colDiscoID = 2;
global.importCSVGrid_colPID = 3;
global.importCSVGrid_colSpeaker = 4;
global.importCSVGrid_colUID = 5;
global.importCSVGrid_colWID = 6;
global.importCSVGrid_colPlace = 7;
global.importCSVGrid_colWord = 10;
global.importCSVGrid_colText = 11;
global.importCSVGrid_colUnitStart = 22;
global.importCSVGrid_colUnitEnd = 23;

global.importCSVUnitGridHeight = 0;



global.importGridWidth = 0;
global.importCSVGridWidth = 0;
global.importGrid = ds_grid_create(global.importGridWidth, 0);
global.importGridColMap = ds_map_create();

global.importGridTokenCountList = ds_list_create();


global.importTXTLineGridWidth = 2;
global.importTXTLineGrid_colLine = 0;
global.importTXTLineGrid_colException = 1;
global.importTXTLineGrid = ds_grid_create(global.importTXTLineGridWidth, 0);



global.importFilename = "";
scr_importMappingGridsInit();


global.importFileRipList = ds_list_create();



global.tagInfoGridWidth = 8;
global.tagInfoGrid_colMarker = 0;
global.tagInfoGrid_colExample = 1;
global.tagInfoGrid_colLevel = 2;
global.tagInfoGrid_colMarkerPercent = 3;
global.tagInfoGrid_colSingleTokenMarker = 4;
global.tagInfoGrid_colTokenCount = 5;
global.tagInfoGrid_colSpecialFields = 6;
global.tagInfoGrid_colError = 7;

global.tagInfoGrid = ds_grid_create(global.tagInfoGridWidth, 0);





// Block Type Grid
global.blockTypeGridWidth = 6;
global.blockTypeGrid_colDefault = 0;
global.blockTypeGrid_colBlockCategory = 1;
global.blockTypeGrid_colBlockType = 2;
global.blockTypeGrid_colBlockCount = 3;
global.blockTypeGrid_colLinesPerBlock = 4;
global.blockTypeGrid_colFieldList = 5;
global.blockTypeGrid = ds_grid_create(global.blockTypeGridWidth, 0);
global.blockCategoryUnit = 0;
global.blockCategoryHeader = 1;


// Block Grid
global.blockGridWidth = 4;
global.blockGrid_colBlockID = 0;
global.blockGrid_colBlockType = 1;
global.blockGrid_colLineList = 2;
global.blockGrid_colTokenCountList = 3;
global.blockGrid = ds_grid_create(global.blockGridWidth, 0);
global.blockIDList = ds_list_create();


global.fieldLevelMap = ds_map_create();


// Field Relation Grid
global.fieldRelationGridWidth = 3;
global.fieldRelationGrid_colField = 0;
global.fieldRelationGrid_colEncounteredFields = 1;
global.fieldRelationGrid_colOneToOneFieldList = 2;
global.fieldRelationGrid = ds_grid_create(global.fieldRelationGridWidth, 0);

// Field Relation Helper Grid
global.fieldRelationHelperGridWidth = 0;
global.fieldRelationHelperGrid = ds_grid_create(global.fieldRelationHelperGridWidth, 0);












//variables for keyboard
cursorPos = 1 ;
cursorViz = false;
inputText = "";
cursorTimer = 20;
global.userName = "";

maxDisplaySize = 12;
canDelete = true;
canDeleteHoldingCounter = 0;
canPressLeft = true;
canPressLeftHoldingCounter = 0;
canPressRight = true;
canPressRightHoldingCounter = 0;
holdingLimit = 6;
loopItterations = 0;



// variables for different games
global.wheresElmo = false;
global.rezzles = false;

//ini variables

global.autosaveTimer = 36000;
global.previousRezDirectory = "";
global.previousImportDirectory = "";
global.fileExtentionOrder = "TXT file|*.txt|XML file|*.xml|CSV file|*.csv|JSON file|*.json";
global.previousLevelEstimates = ds_list_create();
global.previousSpecialFields = ds_list_create();
ds_list_clear(global.previousLevelEstimates);
ds_list_clear(global.previousSpecialFields);

global.readHintHide = false;
global.fontSize = 0;

scr_loadINI();



global.unitImportUnitStartColName = "";
global.unitImportUnitEndColName = "";
global.unitImportUnitDelimColName = "";
global.unitImportTurnDelimColName = "";
global.wordImportWordDelimColName = "";
global.unitImportTranslationColName = "";
global.unitImportSpeakerColName = "";
global.tokenImportTranscriptColName = "";
global.tokenImportDisplayTokenColName = "";

global.openedREZFile = false;



global.scrollBarWidth = 20;
scr_fontGlobalUpdate();

canPressMinus = true;
canPressPlus = true;

// put a small delay on activating the documentation button, so that users won't accidentally
// click on it when hopping back to OpeningScreen
documentationButtonActive = false;
alarm[3] = 3;


alarm[2] = 1;

global.exitOut = false;


// this map tells Rezonator what dropdowns expand to further dropdowns
// so we can look up the strings in this map to know whether or not to draw the expand arrow
global.expandableDropDownMap = ds_map_create();
ds_map_add(global.expandableDropDownMap, "Delete All", true);
ds_map_add(global.expandableDropDownMap, "Window", true);
ds_map_add(global.expandableDropDownMap, "Nav", true);
ds_map_add(global.expandableDropDownMap, "menu_justify", true);
ds_map_add(global.expandableDropDownMap, "menu_prose", true);
ds_map_add(global.expandableDropDownMap, "menu_hide", true);
ds_map_add(global.expandableDropDownMap, "menu_pick", true);
ds_map_add(global.expandableDropDownMap, "menu_filter-context", true);
ds_map_add(global.expandableDropDownMap, "menu_search", true);
ds_map_add(global.expandableDropDownMap, "menu_stack", true);
ds_map_add(global.expandableDropDownMap, "Stacker", true);
ds_map_add(global.expandableDropDownMap, "Play and Learn", true);
ds_map_add(global.expandableDropDownMap, "menu_zoom", true);
ds_map_add(global.expandableDropDownMap, "Autosave", true);
ds_map_add(global.expandableDropDownMap, "Advanced", true);
ds_map_add(global.expandableDropDownMap, "Language", true);


global.optionListTypeSort = 0;
global.optionListTypeChainList = 1;
global.optionListTypeChainRecolor = 2;
global.optionListTypeSpeakerLabel = 3;
global.optionListTypeFile = 4;
global.optionListTypeAdvanced = 5;
global.optionListTypeView = 6;
global.optionListTypeSearch = 7;
global.optionListTypeRightClickWord = 8;
global.optionListTypeWordTags = 9;
global.optionListTypeGame = 10;
global.optionListTypeNewWord = 11;
global.optionListTypeMappingTag = 12;
global.optionListTypeZoom = 13;
global.optionListTypePane = 14;
global.optionListTypeWord = 15;
global.optionListTypeJustify = 16;
global.optionListTypeProse = 17;
global.optionListTypeHide = 18;
global.optionListTypeContext = 19;
global.optionListTypeClear = 20;
global.optionListTypeSettings = 21;
global.optionListTypeTools = 22;
global.optionListTypeHelp = 23;
global.optionListTypeToolsSort = 24;
global.optionListTypeStackShow = 25;
global.optionListTypeDelete = 26;
global.optionListTypeTokenSelection = 27;
global.optionListTypeStack = 28;
global.optionListTypeCreateStack = 29;
global.optionListTypeShowStack = 30;
global.optionListTypeUnitSelection = 31;
global.optionListTypeSpecialFields = 32;
global.optionListTypeFilter = 33;
global.optionListTypeAddToFilter = 34;
global.optionListTypeTokenTagMap = 35;
global.optionListTypeTokenMarker = 36;
global.optionListTypeUnitMarker = 37;
global.optionListTypeUnitTagMap = 38;
global.optionListTypeGridViewerSelectGrid = 39;
global.optionListTypeAutosave = 40;
global.optionListTypeStackTag = 41;
global.optionListTypeEdit = 42;
global.optionListTypePlayAndLearn = 43;
global.optionListTypeNav = 44;
global.optionListTypeLanguage = 45;
global.optionListTypeImportGrid = 46;

scr_preImportInitiate();
showPreImportScreen = false;

global.tokenCountTotal = 0;