/*
	scr_shuffleDisplayRows();
	
	Last Updated: 2018-07-12
	
	Called from: obj_control
	
	Purpose: shuffle the lineGrid's rows
	
	Mechanism: create a shuffled list of the rows in the lineGrid, create a temporaryGrid to set
				new row information to, copy information from temporaryGrid to lineGrid
*/

var gridSource = obj_control.lineGrid;
var gridShuffle = ds_grid_create(ds_grid_width(gridSource), ds_grid_height(gridSource));

var gridSourceRowsToCopy = ds_list_create();

for (var i = 0; i < ds_grid_height(gridSource); i++)
{
	ds_list_add(gridSourceRowsToCopy, i);
}

ds_list_shuffle(gridSourceRowsToCopy);




for (var j = 0; j < ds_list_size(gridSourceRowsToCopy); j++)
{
	var rowToCopy = ds_list_find_value(gridSourceRowsToCopy, j);
	
	for (var k = 0; k < ds_grid_width(gridSource); k++)
	{
		var value = ds_grid_get(gridSource, k, rowToCopy);
		ds_grid_set(gridShuffle, k, j, value);
	}
}

ds_grid_copy(gridSource, gridShuffle);
/*for (var i = 0; i < ds_grid_height(obj_control.lineGrid); i++)
{
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelY, i, i * obj_control.gridSpaceVertical);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, i, i * obj_control.gridSpaceVertical);
}*/
scr_refreshLineGridPixelY();

ds_grid_destroy(gridShuffle);