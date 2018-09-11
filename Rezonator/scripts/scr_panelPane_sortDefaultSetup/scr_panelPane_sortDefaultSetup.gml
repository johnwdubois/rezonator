if not (currentFunction == functionSort)
{
	exit;
}

for (var i = 0; i < 10; i++)
{
	var textMarginTop = 20;
	functionSort_colY[i] = y + textMarginTop + 24 + (i * 24) - (sprite_get_height(spr_ascend) / 2);
}



//lineGrid
var sortGridLineGrid = ds_grid_create(functionSort_gridSortGridWidth, 4);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colCol, 0, obj_control.lineGrid_colDiscoID);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colAscend, 0, true);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colMouseover, 0, false);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colCol, 1, obj_control.lineGrid_colUnitStart);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colAscend, 1, true);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colMouseover, 1, false);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colCol, 2, obj_control.lineGrid_colUnitEnd);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colAscend, 2, true);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colMouseover, 2, false);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colCol, 3, obj_control.lineGrid_colLineNumberLabel);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colAscend, 3, true);
ds_grid_set(sortGridLineGrid, functionSort_gridSortColGrid_colMouseover, 3, false);
	
ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colGrid, 0, obj_control.lineGrid);
ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colHard, 0, false);
ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colSortGrid, 0, sortGridLineGrid);
	
	
	
	
//unitGrid
var sortGridUnitGrid = ds_grid_create(functionSort_gridSortGridWidth, 1);
ds_grid_set(sortGridUnitGrid, functionSort_gridSortColGrid_colCol, 0, obj_control.unitGrid_colUnitID);
ds_grid_set(sortGridUnitGrid, functionSort_gridSortColGrid_colAscend, 0, true);
ds_grid_set(sortGridUnitGrid, functionSort_gridSortColGrid_colMouseover, 0, false);

ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colGrid, 1, obj_control.unitGrid);
ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colHard, 1, true);
ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colSortGrid, 1, sortGridUnitGrid);





//wordGrid
var sortGridWordGrid = ds_grid_create(functionSort_gridSortGridWidth, 1);
ds_grid_set(sortGridWordGrid, functionSort_gridSortColGrid_colCol, 0, obj_control.wordGrid_colWordID);
ds_grid_set(sortGridWordGrid, functionSort_gridSortColGrid_colAscend, 0, true);
ds_grid_set(sortGridWordGrid, functionSort_gridSortColGrid_colMouseover, 0, false);

ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colGrid, 2, obj_control.wordGrid);
ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colHard, 2, true);
ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colSortGrid, 2, sortGridWordGrid);






//searchGrid
var sortGridSearchGrid = ds_grid_create(functionSort_gridSortGridWidth, 4);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colCol, 0, obj_control.lineGrid_colDiscoID);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colAscend, 0, true);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colMouseover, 0, false);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colCol, 1, obj_control.lineGrid_colUnitStart);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colAscend, 1, true);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colMouseover, 1, false);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colCol, 2, obj_control.lineGrid_colUnitEnd);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colAscend, 2, true);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colMouseover, 2, false);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colCol, 3, obj_control.lineGrid_colLineNumberLabel);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colAscend, 3, true);
ds_grid_set(sortGridSearchGrid, functionSort_gridSortColGrid_colMouseover, 3, false);
	
ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colGrid, 3, obj_control.searchGrid);
ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colHard, 3, false);
ds_grid_set(functionSort_gridGrid, functionSort_gridGrid_colSortGrid, 3, sortGridSearchGrid);