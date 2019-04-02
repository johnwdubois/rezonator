var totalUnitAmount = 0;
for (var i = 0; i < ds_grid_height(global.fileLineRipGrid); i++) {
	totalUnitAmount += ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colUnitAmount, i);
}

return totalUnitAmount;