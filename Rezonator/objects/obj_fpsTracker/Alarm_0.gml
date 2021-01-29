alarm[0] = fps * 2;

if (fpsGridCurrentRow >= ds_grid_height(fpsGrid)) {
	exit;
}

ds_grid_set(fpsGrid, fpsGrid_colTime, fpsGridCurrentRow, date_time_string(date_current_datetime()));
ds_grid_set(fpsGrid, fpsGrid_colFPS, fpsGridCurrentRow, fps);
ds_grid_set(fpsGrid, fpsGrid_colNodeMapSize, fpsGridCurrentRow, ds_map_size(global.nodeMap));

fpsGridCurrentRow++;