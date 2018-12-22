var rowInCliqueGrid = argument0;
if (rowInCliqueGrid < 0 or rowInCliqueGrid >= ds_grid_height(obj_chain.cliqueGrid))
{
	exit;
}

var chainIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colChainIDList, rowInCliqueGrid);
var unitIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colUnitIDList, rowInCliqueGrid);
var fullWordIDList = ds_list_create();

for (var i = 0; i < ds_list_size(chainIDList); i++)
{
	var chainID = ds_list_find_value(chainIDList, i);
	var rowInChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), chainID);
	if (rowInChainGrid < 0)
	{
		continue;
	}
	var wordIDList = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, rowInChainGrid);
	for (var j = 0; j < ds_list_size(wordIDList); j++)
	{
		var currentWordID = ds_list_find_value(wordIDList, j);
		ds_list_add(fullWordIDList, currentWordID);
	}
}

var firstWordList = ds_list_create();
for (var i = 0; i < ds_list_size(unitIDList); i++)
{
	var currentUnitID = ds_list_find_value(unitIDList, i);
	var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentUnitID - 1);
	
	var j = 0;
	var currentWordID = ds_list_find_value(currentWordIDList, j);
	while (j < ds_list_size(currentWordIDList) and ds_list_find_index(fullWordIDList, currentWordID) == -1)
	{
		j++;
		currentWordID = ds_list_find_value(currentWordIDList, j);
	}
	
	ds_list_add(firstWordList, currentWordID);
}

var breakExists = true;
for (var i = 0; i < ds_list_size(firstWordList); i++)
{
	var currentWordID = ds_list_find_value(firstWordList, i);
	var currentVoid = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1);
	
	if (currentVoid < 1)
	{
		breakExists = false;
		break;
	}
}
ds_list_destroy(firstWordList);
ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colBreak, rowInCliqueGrid, breakExists);

ds_list_destroy(fullWordIDList);

if (breakExists)
{
	var maxTiltRowInChainGrid = -1;
	var maxTilt = -1;
	for (var i = 0; i < ds_list_size(chainIDList); i++)
	{
		var currentChain = ds_list_find_value(chainIDList, i);
		var currentRowInChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), currentChain);
		var currentTilt = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colTiltSum, currentRowInChainGrid);
		if (currentTilt > maxTilt)
		{
			maxTilt = currentTilt;
			maxTiltRowInChainGrid = currentRowInChainGrid;
		}
	}
	
	ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, maxTiltRowInChainGrid, false);
}