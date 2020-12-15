global.importGroupDir = "";
global.importGroupFileList = ds_list_create();
global.importGroupFileIndex = 0;
global.importGroupOutputDir = "";
global.importGroupSchemaFile = "";
global.skipToImportScreen = false;
global.skipToPlayandLearn = false;

scr_initializeFonts();
scr_fontGlobalUpdate();

global.fontsLoaded = false;
global.loadingScreenCreated = false;

alarm[4] = 2;