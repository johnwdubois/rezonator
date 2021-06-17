scr_createRezDirectory();

global.currentDirString = global.rezonatorDirString;
global.fontSize = 0;


scr_loadINI();

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


// translation visualization maps
global.reverseStrMap = ds_map_create();
global.strToLangMap = ds_map_create();




// CREATING THE LEGENDARY NODE MAP
global.nodeMap = ds_map_create();

global.searchMap = -1;

window_set_min_width(800);
window_set_min_height(720);


// CHANGE THIS VAR WHEN MAKING A BUILD
// if build is true --> CJK fonts will be loaded
// if build is false --> CJK fonts will not be loaded
global.build = false;