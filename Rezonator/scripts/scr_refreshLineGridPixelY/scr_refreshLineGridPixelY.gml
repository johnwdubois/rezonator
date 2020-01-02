// Refresh the lineGrid's PixelY's to fit the current gridSpaceVertical

for (var i = 0; i < ds_grid_height(obj_control.lineGrid); i++)
{
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelY, i, i * obj_control.gridSpaceVertical);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, i, i * obj_control.gridSpaceVertical);
}