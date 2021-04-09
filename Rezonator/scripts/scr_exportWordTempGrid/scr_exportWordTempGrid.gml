// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportWordTempGrid(headerList){

	var wordGrid = ds_grid_create(ds_grid_width(obj_control.wordGrid), ds_grid_height(obj_control.wordGrid));
	ds_grid_copy(wordGrid, obj_control.wordGrid);
	
	var newWordGridWidth = ds_list_size(headerList);
	var wordGridHeight = ds_grid_height(wordGrid);
	var previousWordGridWidth = ds_grid_width(wordGrid);
	
	ds_grid_resize(wordGrid,newWordGridWidth,wordGridHeight)	
	
	
	var tokenImportGridWidth = ds_grid_width(global.tokenImportGrid);	
	
	ds_grid_set_grid_region(wordGrid,global.tokenImportGrid, 4,0,tokenImportGridWidth,ds_grid_height(global.tokenImportGrid),previousWordGridWidth,0);
	
	return(wordGrid);
}