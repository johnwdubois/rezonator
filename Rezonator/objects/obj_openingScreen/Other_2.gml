scr_createRezDirectory();

global.currentDirString = global.rezonatorDirString;
global.fontSize = 0;

//ini variables
global.autosaveTimerFull = 600;
global.autosaveTimer = global.autosaveTimerFull;
global.previousRezDirectory = "";
global.previousImportDirectory = "";
global.fileExtentionOrder = "TXT file|*.txt|XML file|*.xml|CSV file|*.csv|JSON file|*.json";
global.previousLevelEstimates = ds_list_create();
global.previousSpecialFields = ds_list_create();
ds_list_clear(global.previousLevelEstimates);
ds_list_clear(global.previousSpecialFields);

global.readHintHide = false;



global.importType_Default = 0;
global.importType_CSV = "One Word per Line";
global.importType_CoNLLU = "CoNLL-U";
global.importType_IGT = "Interlinear Glossed Text";
global.importType_PlainText = "Song & Verse";
global.importType_TabDelimited = "Elan (tab-delimited)";
global.importType_Paragraph = "Prose";
global.importType_Transcription = "Transcription";



// by default, we will set importType to be the first item in the importTypeList
global.importType = global.importType_PlainText;


scr_loadINI();

global.importGroupDir = "";
global.importGroupFileList = ds_list_create();
global.importGroupFileIndex = 0;
global.importGroupOutputDir = "";
global.importGroupSchemaFile = "";
global.skipToImportScreen = false;


scr_initializeFonts();
scr_fontGlobalUpdate();

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


// CHANGE THIS VAR WHEN MAKING A BUILD
// if build is true --> CJK fonts will be loaded
// if build is false --> CJK fonts will not be loaded
global.build = true;