//  Race to infinity safety checks
var grid;
var rowInChainGrid = -1;
rowInChainGrid = ds_grid_value_y(rezChainGrid, chainGrid_colChainID, 0, chainGrid_colChainID, ds_grid_height(rezChainGrid), chainIDRaceCheck);
grid = rezChainGrid;
if (rowInChainGrid < 0 or rowInChainGrid >= ds_grid_height(rezChainGrid)) {
	rowInChainGrid = ds_grid_value_y(trackChainGrid, chainGrid_colChainID, 0, chainGrid_colChainID, ds_grid_height(trackChainGrid), chainIDRaceCheck);
	grid = trackChainGrid;
}
if (rowInChainGrid < 0 or rowInChainGrid >= ds_grid_height(rezChainGrid)) {
	exit;
}

scr_raceCheckChain(grid, rowInChainGrid);