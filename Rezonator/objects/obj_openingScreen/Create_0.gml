/*
	Purpose: Instantiate all variables used by the openingScreen object
*/


if (BUILDTYPE != "Web") window_command_hook(window_command_close);

global.ctrlHold = false;

window_set_cursor(cr_default);

scr_colorThemeGridInit();

 
global.toolPaneWidth = 100;



global.currentVersionStr = scr_strOnlyNumAndPeriod(game_display_name);
global.currentVersionStrFull = "Version " + global.currentVersionStr;
show_debug_message("obj_openingScreen, create, currentVersionStr: " + string(global.currentVersionStr) + ", currentVersionStrFull: " + string(global.currentVersionStrFull));

global.schemaFileName = "";

global.fileLineRipList = ds_list_create();


global.participantColorList = ds_list_create();

global.wordGridWidth = 7;
global.dynamicWordGridWidth = 15;
global.unitGridWidth = 10;



// global.project can be equal to "import", "open", or ""
global.project = "";
global.menuOpen = true;
global.neworOpen = false;




global.plainText = false;
global.tabDelimitedText = false;

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


canContinue = false;

participantHueOffset = 0;

showDevVars = false;







global.rememberMe = false;
global.selectedFile = "";

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

global.RTLFound =  false;

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



global.tagInfoGridWidth = 11;
global.tagInfoGrid_colMarker = 0;
global.tagInfoGrid_colLevel = 1;
global.tagInfoGrid_colKey = 2;
global.tagInfoGrid_colSpecialFields = 3;
global.tagInfoGrid_colLevelSchema = 4;
global.tagInfoGrid_colError = 5;
global.tagInfoGrid_colLevelPredict = 6;
global.tagInfoGrid_colTokenCount = 7;
global.tagInfoGrid_colMarkerPercent = 8;
global.tagInfoGrid_colSingleTokenMarker = 9;
global.tagInfoGrid_colSplit = 10;












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



// create font iterator
CJKLoopIteration = 0;




//variables for keyboard
cursorPos = 1 ;
cursorViz = false;
inputText = "";
cursorTimer = 20;
  

maxDisplaySize = 12;
canDelete = true;
canDeleteHoldingCounter = 0;
canPressLeft = true;
canPressLeftHoldingCounter = 0;
canPressRight = true;
canPressRightHoldingCounter = 0;
holdingLimit = 6;
loopItterations = 0;












global.unitImportUnitStartColName = "";
global.unitImportUnitEndColName = "";
global.unitDelimField = "";
global.unitImportTurnDelimColName = "";
global.psentDelimField = "";
global.wordDelimField = "";
global.currentTranslation = "";
global.unitImportSpeakerColName = "";
global.tokenImportTranscriptColName = "";
global.tokenImportDisplayTokenColName = "";
global.conlluAutotagColName = "";

global.translationList = ds_list_create();

global.openedREZFile = false;


global.displayTokenField = "";
global.participantField = "";



global.scrollBarWidth = 20;


canPressMinus = true;
canPressPlus = true;

// put a small delay on activating the documentation button, so that users won't accidentally
// click on it when hopping back to OpeningScreen
documentationButtonActive = false;
alarm[3] = 3;


alarm[2] = 1;

global.exitOut = false;


scr_dropDownOptionListTypeInit();

scr_expandableDropDownInit();

// This map stores all the dropdown options that are clickable in the opening screen
global.openingScreenDropDownMap = ds_map_create();
ds_map_add(global.openingScreenDropDownMap, "menu_import", true);
ds_map_add(global.openingScreenDropDownMap, "option_aichat", true);
ds_map_add(global.openingScreenDropDownMap, "help_label_open", true);
ds_map_add(global.openingScreenDropDownMap, "menu_guide", true);
ds_map_add(global.openingScreenDropDownMap, "menu_about", true);
ds_map_add(global.openingScreenDropDownMap, "menu_theme", true);
ds_map_add(global.openingScreenDropDownMap, "menu_zoom", true);
ds_map_add(global.openingScreenDropDownMap, "help_label_zoom-in", true);
ds_map_add(global.openingScreenDropDownMap, "help_label_zoom-out", true);
ds_map_add(global.openingScreenDropDownMap, "menu_check-updates", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-en", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-ca", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-es", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-he", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-it", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-ja", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-vi", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-zh", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-hy", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-gu", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-kk", true);
ds_map_add(global.openingScreenDropDownMap, "menu_language-ru", true);








// This map stores all the keyboard shortcuts to be displayed on the tooltip
var ctrlStr = (os_type == os_macosx) ? "CMD" : "CTRL";
global.keyboardShortcutMap = ds_map_create();
ds_map_add(global.keyboardShortcutMap, "menu_keyword", "F");
ds_map_add(global.keyboardShortcutMap, "menu_go-to-line", "G");
ds_map_add(global.keyboardShortcutMap, "menu_save", ctrlStr + "+S");
ds_map_add(global.keyboardShortcutMap, "menu_grid", ctrlStr + "+G");
ds_map_add(global.keyboardShortcutMap, "menu_theme", ctrlStr + "+B");
ds_map_add(global.keyboardShortcutMap, "help_label_zoom-in", ctrlStr + " SHIFT +");
ds_map_add(global.keyboardShortcutMap, "help_label_zoom-out", ctrlStr + " SHIFT -");
ds_map_add(global.keyboardShortcutMap, "help_label_tall-rows", "SHIFT +");
ds_map_add(global.keyboardShortcutMap, "help_label_short", "SHIFT -");
ds_map_add(global.keyboardShortcutMap, "menu_wide", ctrlStr + " +");
ds_map_add(global.keyboardShortcutMap, "menu_narrow", ctrlStr + " -");
ds_map_add(global.keyboardShortcutMap, "menu_justify", "J");
ds_map_add(global.keyboardShortcutMap, "menu_prose", "K");
ds_map_add(global.keyboardShortcutMap, "menu_exit", "SHIFT+Q");
ds_map_add(global.keyboardShortcutMap, "menu_pick", "P");
ds_map_add(global.keyboardShortcutMap, "menu_filter-context", "C");
ds_map_add(global.keyboardShortcutMap, "menu_search", "V");
ds_map_add(global.keyboardShortcutMap, "menu_filter", ctrlStr + "+P");
ds_map_add(global.keyboardShortcutMap, "menu_track", "T");
ds_map_add(global.keyboardShortcutMap, "menu_resonance", "R");
ds_map_add(global.keyboardShortcutMap, "menu_developer", "ALT+SHIFT+D");


// This map stores the toggle state of all the toggleable dropdowns
global.checkDropdownMap = ds_map_create();
ds_map_add(global.checkDropdownMap, "menu_resonance", false);
ds_map_add(global.checkDropdownMap, "menu_track", false);
ds_map_add(global.checkDropdownMap, "menu_stack", false);
ds_map_add(global.checkDropdownMap, "menu_read", false);
ds_map_add(global.checkDropdownMap, "menu_left", false);
ds_map_add(global.checkDropdownMap, "menu_right", false);
ds_map_add(global.checkDropdownMap, "menu_prose", false);
ds_map_add(global.checkDropdownMap, "menu_grid", false);
ds_map_add(global.checkDropdownMap, "menu_left-to-right", false);
ds_map_add(global.checkDropdownMap, "menu_right-to-left", false);
ds_map_add(global.checkDropdownMap, "menu_track-arrows", false);
ds_map_add(global.checkDropdownMap, "menu_rez-arrows", false);
ds_map_add(global.checkDropdownMap, "Track", false); // localize
ds_map_add(global.checkDropdownMap, "menu_language-en", false);
ds_map_add(global.checkDropdownMap, "menu_language-ca", false);
ds_map_add(global.checkDropdownMap, "menu_language-es", false);
ds_map_add(global.checkDropdownMap, "menu_language-he", false);
ds_map_add(global.checkDropdownMap, "menu_language-it", false);
ds_map_add(global.checkDropdownMap, "menu_language-ja", false);
ds_map_add(global.checkDropdownMap, "menu_language-vi", false);
ds_map_add(global.checkDropdownMap, "menu_language-zh", false);
ds_map_add(global.checkDropdownMap, "menu_language-hy", false);
ds_map_add(global.checkDropdownMap, "menu_language-gu", false);
ds_map_add(global.checkDropdownMap, "menu_language-kk", false);
ds_map_add(global.checkDropdownMap, "menu_language-ru", false);
ds_map_add(global.checkDropdownMap, "menu_5-min", false);
ds_map_add(global.checkDropdownMap, "menu_10-min", false);
ds_map_add(global.checkDropdownMap, "menu_20-min", false);
ds_map_add(global.checkDropdownMap, "menu_30-min", false);
ds_map_add(global.checkDropdownMap, "menu_off", false);
ds_map_add(global.checkDropdownMap, "word_tip", false);
ds_map_add(global.checkDropdownMap, "unit_tip", false);
ds_map_add(global.checkDropdownMap, "help_label_tag", false);
ds_map_add(global.checkDropdownMap, "tab_name_chunk", false);
ds_map_add(global.checkDropdownMap, "menu_help", false);
ds_map_add(global.checkDropdownMap, "menu_navigation", false);
ds_map_add(global.checkDropdownMap, "menu_toolbar", false);

global.html5RestrictedMap = ds_map_create();
ds_map_add(global.html5RestrictedMap, "menu_save", true);
ds_map_add(global.html5RestrictedMap, "menu_save-as", true);
ds_map_add(global.html5RestrictedMap, "menu_media", true);
ds_map_add(global.html5RestrictedMap, "menu_export", true);
ds_map_add(global.html5RestrictedMap, "menu_check-updates", true);
ds_map_add(global.html5RestrictedMap, "menu_import", true);
ds_map_add(global.html5RestrictedMap, "menu_autosave", true);



//checkmarkKeys = [];
//ds_map_keys_to_array(global.checkDropdownMap, checkmarkKeys);
//for (var i = 0; i < array_length(checkmarkKeys); i++) {
//	show_debug_message(checkmarkKeys[i]);
//}


global.tokenCountTotal = 0;

global.discourseNode = "";

global.prevTimePrinted = current_time;

alarm[5] = 2;

hoverColorMergeOpen = 0;
hoverColorMergeImport = 0;
hoverColorMergeHelp = 0;

global.dirCopyDebugList = ds_list_create();

showDownloadDialogue = false;
alreadyShownDownloadDialogue = false;

global.CoNLLUwithMeta = false;
global.schemaNavTokenFieldList = -1;
global.schemaNavUnitFieldList = -1;

alarm[6] = 1;


global.includedTagSchemaFileList = ds_list_create();
scr_addtoTagSchemaList();
global.selectedTagSchemaFileList = ds_list_create();

global.importFieldTagList = ds_list_create();

global.userLangRTL = false;

global.restoreAutosave = false;
global.autosaveLastSavedFilename = "";
global.importFrom = "file";



selectOpenButton = false;
openedFile = "";

fontSizeTest = 0;
runFontSizeTest = false;
ret = -1;