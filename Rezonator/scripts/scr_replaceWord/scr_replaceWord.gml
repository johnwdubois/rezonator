var wordID = argument0;
var replaceStr = argument1;
//var originalStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, wordID - 1);



ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord, wordID - 1, replaceStr);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, wordID - 1, replaceStr);