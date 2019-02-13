/*
for (var i = 0; i < ds_grid_height(obj_control.unitGrid); i++)
{
	var currentUnitID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitID, i);
	var emptyList = ds_list_create();
	
	var unitInStackGridCurrentRow = ds_grid_height(unitInStackGrid);
	ds_grid_resize(unitInStackGrid, unitInStackGridWidth, unitInStackGridCurrentRow + 1);
	ds_grid_set(unitInStackGrid, unitInStackGrid_colUnitID, unitInStackGridCurrentRow, currentUnitID);
	ds_grid_set(unitInStackGrid, unitInStackGrid_colStackList, unitInStackGridCurrentRow, emptyList);
}
*/