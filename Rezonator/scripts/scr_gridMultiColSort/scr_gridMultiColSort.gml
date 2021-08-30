function scr_gridMultiColSort() {


	if (argument_count < 3) {
		return -1;
	}
	
	var grid, args, args, argsCount;

	grid = argument[0];
	argsCount = (argument_count - 1) div 2;

	for (var i = argsCount - 1; i >= 0; i--) {
		args[i,1] = argument[i * 2 + 2]; //set ascending
		args[i,0] = argument[i * 2 + 1]; //set descending
	}

	scr_gridMultiColSortPart(grid,args,0);


}
