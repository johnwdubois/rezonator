fpsGridWidth = 3;
fpsGrid_colTime = 0;
fpsGrid_colFPS = 1;
fpsGrid_colNodeMapSize = 2;

fpsGridCurrentRow = 0;

fpsGrid = ds_grid_create(fpsGridWidth, 100000);

alarm[0] = fps * 2;