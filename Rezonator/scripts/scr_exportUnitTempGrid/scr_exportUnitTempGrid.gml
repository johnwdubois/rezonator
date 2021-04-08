// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportUnitTempGrid(headerList){

	var unitGrid = ds_grid_create(ds_grid_width(obj_control.unitGrid), ds_grid_height(obj_control.unitGrid));
	
	ds_grid_copy(unitGrid, obj_control.unitGrid);
	
	var newunitGridWidth = ds_list_size(headerList);
	var unitGridHeight = ds_grid_height(unitGrid);
	var previousunitGridWidth = ds_grid_width(unitGrid);
	
	ds_grid_resize(unitGrid,newunitGridWidth,unitGridHeight)	
	
	
	var unitImportGridWidth = ds_grid_width(global.unitImportGrid);	
	var unitImportGridHeight = ds_grid_height(global.unitImportGrid);
	
	ds_grid_set_grid_region(unitGrid,global.unitImportGrid, 2,0,unitImportGridWidth,unitImportGridHeight,previousunitGridWidth,0);
	
	return(unitGrid);
}