function scr_refreshLineGridPixelY() {
	// Refresh the lineGrid's PixelY's to fit the current gridSpaceVertical
	var lineGridHeight = ds_grid_height(obj_control.lineGrid);
	for (var i = 0; i < lineGridHeight; i++)
	{
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelY, i, i * obj_control.gridSpaceVertical);
		ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, i, i * obj_control.gridSpaceVertical);
	}


}
