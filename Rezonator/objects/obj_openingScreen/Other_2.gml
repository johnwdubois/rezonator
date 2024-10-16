scr_createRezDirectory();

global.currentDirString = global.rezonatorDirString;
scr_defaultINISettings();

//ini variables
global.autosaveTimerFull = 600;
global.autosaveTimer = global.autosaveTimerFull;
global.previousRezDirectory = "";
global.previousImportDirectory = "";
global.previousSaveDirectory = "";
global.previousAudioDirectory = "";
global.previousLevelEstimates = ds_list_create();
global.previousSpecialFields = ds_list_create();
ds_list_clear(global.previousLevelEstimates);
ds_list_clear(global.previousSpecialFields);

global.readHintHide = false;
global.userName = "";

global.recentFilesMap = ds_map_create();
global.recentFilesList = ds_list_create();
global.usedImports = ds_list_create();



// by default, we will set importType to be the first item in the importTypeList
global.importType = IMPORTTYPE_SONG;


global.importGroupDir = "";
global.importGroupFileList = ds_list_create();
global.importGroupFileIndex = 0;
global.importGroupOutputDir = "";
global.importGroupSchemaFile = "";
global.skipToImportScreen = false;
global.skipToAiChat = false;
global.skipToOpen = false;


global.inputBoxDefStr = global.userName;

scr_initializeFonts();

global.fontsLoaded = false;
global.loadingScreenCreated = false;

alarm[4] = 2;


// translation visualization maps
global.reverseStrMap = ds_map_create();
global.strToLangMap = ds_map_create();




// CREATING THE LEGENDARY NODE MAP
global.nodeMap = ds_map_create();



// CREATING THE NOT SO LEGENDARY COLOR MAP
global.colorMap = -1;

global.searchMap = -1;

global.cliqueMap = -1;



window_set_min_width(800);
window_set_min_height(720);


global.aiChatAPIKey = "";
global.aiChatMsgList = ds_list_create();