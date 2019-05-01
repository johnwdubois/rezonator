var wordID = argument0;
var originalStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, wordID - 1);

var replaceStr = get_string("Edit word:", originalStr);

ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord, wordID - 1, replaceStr);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, wordID - 1, replaceStr);