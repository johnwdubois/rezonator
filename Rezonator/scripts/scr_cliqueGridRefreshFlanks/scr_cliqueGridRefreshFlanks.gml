var rowInCliqueGrid = argument0;

var chainIDList = ds_grid_get(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colChainIDList, rowInCliqueGrid);

var flankLeft = 99999999;
var flankRight = 0;

for (var i = 0; i < ds_list_size(chainIDList); i++)
{
	var currentChainID = ds_list_find_value(chainIDList, i);

	// if this is a Track chain (or is not in rezChainGrid), we don't care about it
	var rowInChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), currentChainID);
	if (rowInChainGrid == -1)
	{
		if (obj_control.showDevMessages)
		{
			show_message("could not find chain " + string(currentChainID));
		}
		exit;
	}
	
	var currentWordIDList = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, rowInChainGrid);
	
	for (var j = 0; j < ds_list_size(currentWordIDList); j++)
	{
		var currentWordID = ds_list_find_value(currentWordIDList, j);
		
		if (currentWordID >= 0 and currentWordID <= ds_grid_height(obj_control.wordGrid))
		{
			var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
			
			if (currentDisplayCol < flankLeft)
			{
				flankLeft = currentDisplayCol;
			}
			if (currentDisplayCol > flankRight)
			{
				flankRight = currentDisplayCol;
			}
						
		}
	}
}

/*
if (obj_control.showDevMessages)
{
	show_message("flankLeft = " + string(flankLeft) + ", flankRight = " + string(flankRight))
}
*/
			
ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colFlankLeft, rowInCliqueGrid, flankLeft);
ds_grid_set(obj_chain.cliqueGrid, obj_chain.cliqueGrid_colFlankRight, rowInCliqueGrid, flankRight);