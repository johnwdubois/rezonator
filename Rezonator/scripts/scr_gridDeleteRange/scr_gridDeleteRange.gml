var grid = argument0;
var col = argument1;
var gridRangeBegining = argument2;
var gridRangeEnd = argument3;

var gridReturn = ds_grid_create(ds_grid_width(grid),0);

for (var i = 0; i< ds_grid_height(grid); i++ ) {
	var currentCell = ds_grid_get(grid,col, i);
	if(real(currentCell) >= gridRangeBegining && real(currentCell) <= gridRangeEnd){
		ds_grid_resize(gridReturn, ds_grid_width(gridReturn), ds_grid_height(gridReturn) + 1);
		for(var j = 0; j < ds_grid_width(grid); j++){
			var currentCellCopy = ds_grid_get(grid,j,i);
			
			if (scr_isItemAList(grid,j,i)) {
				currentCellCopy = ds_list_create();
				ds_list_copy(currentCellCopy, ds_grid_get(grid,j,i));
					//show_message(scr_getStringOfList(currentCellCopy));
			}
			
		ds_grid_set(gridReturn, j, ds_grid_height(gridReturn)-1, currentCellCopy);
			
		}
		
	}
}


return gridReturn;