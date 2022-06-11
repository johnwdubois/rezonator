scr_createRezDirectory();

global.currentDirString = global.rezonatorDirString;
global.fontSize = 0;

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


global.importType_Default = 0;
global.importType_CSV = "import_type_word";
global.importType_CoNLLU = "import_type_conllu";
global.importType_IGT = "import_type_interlinear";
global.importType_PlainText = "import_type_song";
global.importType_TabDelimited = "import_type_elan";
global.importType_Paragraph = "import_type_prose";
global.importType_Transcription = "import_type_transcription";



// by default, we will set importType to be the first item in the importTypeList
global.importType = global.importType_PlainText;


scr_loadINI();

global.importGroupDir = "";
global.importGroupFileList = ds_list_create();
global.importGroupFileIndex = 0;
global.importGroupOutputDir = "";
global.importGroupSchemaFile = "";
global.skipToImportScreen = false;

var defStr = "";
defStr = (global.userName == "") ? scr_get_translation("msg_signin") : global.userName;
global.inputBoxDefStr = defStr;

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
global.rezzles = true;

global.buildType = "Windows_Website";

//"Windows_GitHub_Master","Mac_GitHub_Master","Windows_GitHub_Release"
//"Mac_GitHub_Release","Steam","Windows_Website", "Mac_Website"

global.steamAPI = false;
alarm[7] = 3;
