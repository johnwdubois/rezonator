/*
	scr_importLinks(fileLineRipListElement);
	
	Last Updated: 2020-01-01
	
	Called from: obj_fileLoader
	
	Purpose: Recreate user's links using loaded in data
	
	Mechanism: Separate te string infor to retrieve the type of chain and WordID, then remake the link
	
	Author: Terry DuBois
*/
function scr_importLinks(fileLineRipListElement) {
	
	var linkSectionLineList = ds_list_create();
	var currentLinkSectionStartIndex = fileLineRipListElement;
	
	if (currentLinkSectionStartIndex > -1)
	{
	
		var currentLinkSectionLoopIndex = currentLinkSectionStartIndex;
		
		while (string_count("</Link>", ds_list_find_value(fileLineRipList, currentLinkSectionLoopIndex)) < 1)
		{
			var linkSectionLine = ds_list_find_value(fileLineRipList, currentLinkSectionLoopIndex);
			ds_list_add(linkSectionLineList, linkSectionLine);
			
			currentLinkSectionLoopIndex++;
		}
	}

	ds_list_delete(linkSectionLineList, 0);

	var db = "";
	var linkSectionLineListSize = ds_list_size(linkSectionLineList);
	for (var i = 0; i < linkSectionLineListSize; i++)
	{
		db += string(ds_list_find_value(linkSectionLineList, i)) + ", ";
	}
	//show_message(db);

	if (ds_list_size(linkSectionLineList) < 1)
	{
		exit;
	}


	var tempGridWidth = string_count(",", ds_list_find_value(linkSectionLineList, 0)) + 1;
	var tempGrid = ds_grid_create(tempGridWidth, 0);

	for (var i = 0; i < linkSectionLineListSize; i++)
	{
		var linkSectionLine = ds_list_find_value(linkSectionLineList, i);
		var copyStringStart = 0;
		var charAt = 0;
	
		ds_grid_resize(tempGrid, tempGridWidth, ds_grid_height(tempGrid) + 1);
		var tempGridCurrentRow = ds_grid_height(tempGrid) - 1;
		var tempGridCurrentCol = 0;
	
		while (charAt < string_length(linkSectionLine))
		{
			if (string_char_at(linkSectionLine, charAt) == "," or charAt == string_length(linkSectionLine) - 1)
			{
				var valueCopied = string_copy(linkSectionLine, copyStringStart, charAt - copyStringStart);
			
				//show_message("valueCopied: " + valueCopied);
			
				var negative = false;
				if (string_count("-", valueCopied) > 0)
				{
					negative = true;
				}
				valueCopied = string_digits(valueCopied);
				valueCopied = real(valueCopied);
			
				if (negative)
				{
					valueCopied = -valueCopied;
				}
			
				//show_message("new value: " + string(valueCopied));
			
				ds_grid_set(tempGrid, tempGridCurrentCol, tempGridCurrentRow, valueCopied);
			
				copyStringStart = charAt;
				tempGridCurrentCol++;
			}
		
			charAt++;
		}
	}

	if (ds_grid_height(tempGrid) < 1)
	{
		exit;
	}

	//ds_grid_resize(obj_chain.linkGrid, ds_grid_width(tempGrid), ds_grid_height(tempGrid));
	//ds_grid_copy(obj_chain.linkGrid, tempGrid);

	var currentChainID = ds_grid_get(tempGrid, obj_chain.linkGrid_colChainID, 0);
	var currentTier = ds_grid_get(tempGrid, obj_chain.linkGrid_colTier, 0);
	var currentSource = ds_grid_get(tempGrid, obj_chain.linkGrid_colSource, 0);
	var currentUnitID = ds_grid_get(tempGrid, obj_control.wordGrid_colWordID, currentSource - 1);
	var tempGridHeight = ds_grid_height(tempGrid);


	for (var i = 0; i < tempGridHeight; i++)
	{	
		currentTier = ds_grid_get(tempGrid, obj_chain.linkGrid_colTier, i);
		currentSource = ds_grid_get(tempGrid, obj_chain.linkGrid_colSource, i);
		currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentSource - 1);
	
		if not (ds_grid_get(tempGrid, obj_chain.linkGrid_colChainID, i) == currentChainID)
		{
			with (obj_chain)
			{
				scr_chainDeselect();
			}
			currentChainID = ds_grid_get(tempGrid, obj_chain.linkGrid_colChainID, i);
		
			with (obj_toolPane)
			{
				switch (currentTier)
				{
					case 1:
						currentTool = toolRezBrush;
						break;
					case 2:
						currentTool = toolTrackBrush;
						break;
					case 3:
						currentTool = toolStackBrush;
						break;
					default:
						break;
				}
		}
		}
	
		with (obj_chain)
		{
			scr_wordClicked(currentSource, currentUnitID);
		}
	}

	with (obj_control)
	{
		scr_refreshChainGrid();
	}

	/*
	var db = "";
	for (var i = 0; i < ds_grid_width(tempGrid); i++)
	{
		for (var j = 0; j < ds_grid_height(tempGrid); j++)
		{
			db += string(ds_grid_get(tempGrid, i, j)) + ", ";
		}
	
		db += "#";
	}
	show_message(db);

/* end scr_importLinks */
}
