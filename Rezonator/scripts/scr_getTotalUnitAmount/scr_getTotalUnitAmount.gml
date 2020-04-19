// Sum up the toal amount of units within the fileLineRipGrid

var totalUnitAmount = 0;
var fileLineRipGridHeight = ds_grid_height(global.fileLineRipGrid);
for (var i = 0; i < fileLineRipGridHeight; i++) {
	totalUnitAmount += ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colUnitAmount, i);
}

return totalUnitAmount;