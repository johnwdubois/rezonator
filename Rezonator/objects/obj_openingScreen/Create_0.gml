global.fileLineRipList = ds_list_create();

global.fileLineRipGripWidth = 2;
global.fileLineRipGrid_colDiscoID = 0;
global.fileLineRipGrid_colFileLineRipList = 1;
global.fileLineRipGrid = ds_grid_create(global.fileLineRipGripWidth, 0);

wordAmountList = ds_list_create();

lineTotal = 0;
wordTotal = 0;
wordsToLoad = 0;

//scr_openXML();

//room_goto_next();