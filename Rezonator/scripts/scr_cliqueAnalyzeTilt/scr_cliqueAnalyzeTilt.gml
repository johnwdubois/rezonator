var rowInCliqueGrid = argument0;

if (rowInCliqueGrid < 0 or rowInCliqueGrid >= ds_grid_height(obj_chain.cliqueGrid))
{
	exit;
}

var chainIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colChainIDList, rowInCliqueGrid);
if (ds_list_size(chainIDList) < 1)
{
	exit;
}


var chainMaxTilt = ds_list_find_value(chainIDList, 0);
var chainMaxTiltRowInChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), chainMaxTilt);
if (chainMaxTiltRowInChainGrid < 0 or chainMaxTiltRowInChainGrid >= ds_grid_height(obj_chain.rezChainGrid))
{
	exit;
}
var maxTilt = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colTiltSum, chainMaxTiltRowInChainGrid);

for (var i = 0; i < ds_list_size(chainIDList); i++)
{
	var currentChainID = ds_list_find_value(chainIDList, i);
	var currentRowInChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), currentChainID);
	if (currentRowInChainGrid < 0 or currentRowInChainGrid >= ds_grid_height(obj_chain.rezChainGrid))
	{
		continue;
	}
	var currentTilt = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colTiltSum, currentRowInChainGrid);
	
	if (currentTilt > maxTilt)
	{
		chainMaxTilt = currentChainID;
		maxTilt = currentTilt;
	}
	
	var wordIDList = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, currentRowInChainGrid);
		
	
}

scr_cliqueGetBreak(rowInCliqueGrid);

if (maxTilt < 1)
{
	exit;
}

scr_cliqueGetCross(rowInCliqueGrid);