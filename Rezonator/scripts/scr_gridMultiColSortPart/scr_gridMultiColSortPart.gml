function scr_gridMultiColSortPart() {
	/*
		scr_gridMultiColSortPart(grid, args[,], 0)
	
		Last Updated: 2019-12-27
	
		Called from: scr_gridMultiColSort
	
		Purpose: Sorts passed grid based on multiple columns
	
		Mechanism: Creates temporary grids based on existing grid, sorts those, and uses those
		to overwrite some of the original grid
	*/


	var grid, args, argsSize, i, gridHeight, gridWidth;

	grid = argument[0];
	gridHeight = ds_grid_height(grid);
	gridWidth = ds_grid_width(grid);
	args = argument[1];
	argsSize = array_height_2d(args);
	i = argument[2];

	if (typeof(args[i,0]) != "number") {
		exit;
	}
	else {
		ds_grid_sort(grid,args[i,0],args[i,1]);
	}

	if argsSize -1 = i {
		return -1;
	}

	var col, colNext, rowI;

	col = args[i,0];
	rowI = 0;

	// change cells of grid for each column we sort on
	for (var row = 1; row <= gridHeight; row++) {
		if (row = gridHeight || grid[# col,row] != grid[# col,rowI]) {
			if (row - rowI > 1) {
	            var tempGrid = ds_grid_create(gridWidth,row - rowI);
		
	            ds_grid_set_grid_region(tempGrid,grid,0,rowI,gridWidth - 1,row - 1,0,0);
	            scr_gridMultiColSortPart(tempGrid,args,i + 1);
	            ds_grid_set_grid_region(grid,tempGrid,0,0,gridWidth - 1,row - rowI,0,rowI);
	            ds_grid_destroy(tempGrid);

			}
			rowI = row;
		}
	}


}
