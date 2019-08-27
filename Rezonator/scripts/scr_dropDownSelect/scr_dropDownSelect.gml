
/*
	scr_dropDownSelect();
	
	Last Updated: 2019-08-14
	
	Called from: obj_dropDown
	
	Purpose: draw custom drop down menu with multiple options
	
	Mechanism: draws multiple rectangles and text to represent options to the user.
				
	Author: Terry Dubois, Brady Moore
*/



var optionSelected = argument0;

//optionListType == 0 --> switch sorting columns for sort pane


if (optionListType == 0)
{
	with (obj_panelPane)
	{
		if (currentFunction == functionSort)
		{
			var rowInSortGrid = ds_grid_value_y(functionSort_sortGrid, functionSort_gridSortColGrid_colMouseover, 0, functionSort_gridSortColGrid_colMouseover, ds_grid_height(functionSort_sortGrid), true);
			
			if (rowInSortGrid > -1)
			{
				var newSortCol = ds_grid_get(functionSort_sortGrid, functionSort_gridSortColGrid_colCol, rowInSortGrid);
				//"discoID", "unitStart", "unitEnd", "uID", "unitID"
				switch (optionSelected)
				{
					case "discoID":
						newSortCol = obj_control.lineGrid_colDiscoID;
						break;
					case "unitStart":
						newSortCol = obj_control.lineGrid_colUnitStart;
						break;
					case "unitEnd":
						newSortCol = obj_control.lineGrid_colUnitEnd;
						break;
					case "uID":
						newSortCol = obj_control.lineGrid_colLineNumberLabel;
						break;
					case "unitID":
						newSortCol = obj_control.lineGrid_colUnitID;
						break;
					default:
						break;
				}
				
				ds_grid_set(functionSort_sortGrid, functionSort_gridSortColGrid_colCol, rowInSortGrid, newSortCol);
			}
		}
	}
}
else if (optionListType == 1)
{
	with (obj_panelPane)
	{
		if (currentFunction == functionChainList)
		{
			
						
			
		var grid = obj_chain.rezChainGrid;

		// Based on user selection, get the grid of the current tab
		switch (obj_panelPane.functionChainList_currentTab) {
			case obj_panelPane.functionChainList_tabRezBrush:
				grid = obj_chain.rezChainGrid;
				break;
			case obj_panelPane.functionChainList_tabTrackBrush:
				grid = obj_chain.trackChainGrid;
				break;
			case obj_panelPane.functionChainList_tabStackBrush:
				grid = obj_chain.stackChainGrid;
				break;
			case obj_panelPane.functionChainList_tabClique:
				grid = obj_chain.cliqueDisplayGrid;
				break;
			default:
				grid = obj_chain.rezChainGrid;
				break;
		}
		
		obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
		
		//show_message(ds_grid_height(grid));
		//show_message(obj_control.selectedChainID);
		if(ds_grid_height(grid) > 0){
			var listOfWordID = ds_list_create();
			ds_list_copy(listOfWordID, ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, obj_control.selectedChainID));
		}



			//"Rename", "Recolor", "Delete"
				switch (optionSelected)
				{
					case "Rename":
						//show_message("Rename chosen");
						
						obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 )
						
						
						if (!obj_control.dialogueBoxActive) {
							keyboard_string = "";
							obj_control.rename = true;
						}


						obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}

						break;
					case "Recolor":
						//show_message("Recolor chosen");
						
											
						obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
	
	
	
	
						var dropDownOptionList = ds_list_create();
						ds_list_add(dropDownOptionList, "Red", "Blue", "Green", "Gold", "Custom");
						
						if (ds_list_size(dropDownOptionList) > 0) {
							var dropDownInst = instance_create_depth(mouse_x, mouse_y, -999, obj_dropDown);
							dropDownInst.optionList = dropDownOptionList;
							dropDownInst.optionListType = 2;
					
							obj_control.ableToCreateDropDown = false;
							obj_control.alarm[0] = 2;
						}
	
						/*
						
						if (!obj_control.dialogueBoxActive) {
							keyboard_string = "";
							obj_control.recolor = true;
						}


						obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}
						
						
						*/
						break;
					case "Delete":
						//show_message("Delete chosen");

							var focusedRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
							obj_control.selectedChainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, focusedRow);
							
							//show_message("focused Row: " + string(focusedRow));
							//show_message("chainId: " + string(obj_control.selectedChainID));
						/*
						var focusedRow = -1;
						if(focusedRow == -1){
							var focusedRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid), obj_chain.chainStateFocus);

							//var chosenGrid = ds_grid_copy(chosenGrid, obj_chain.rezChainGrid);
						
						
						if(focusedRow == -1){
							var focusedRow = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid) , 2 );
							//var chosenGrid = ds_grid_copy(chosenGrid, obj_chain.trackChainGrid);
						}
						if(focusedRow == -1){
							var focusedRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid) , 2 );
							//var chosenGrid = ds_grid_copy(chosenGrid, obj_chain.stackChainGrid);
						}
						*/
						scr_deleteEntireChain(obj_control.selectedChainID);
							
						break;
					case "Caption":
					//show_message("Caption clicked");

						obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
	
		
						if (!obj_control.dialogueBoxActive) {
							keyboard_string = "";
							obj_control.caption = true;
						}


						obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}
						break;
					default:
						break;
				}
					
		}
	}
}
else if (optionListType == 2)
{
	with (obj_panelPane)
	{
		if (currentFunction == functionChainList)
		{
			
			
					
		var grid = obj_chain.rezChainGrid;

		// Based on user selection, get the grid of the current tab
		switch (obj_panelPane.functionChainList_currentTab) {
			case obj_panelPane.functionChainList_tabRezBrush:
				grid = obj_chain.rezChainGrid;
				break;
			case obj_panelPane.functionChainList_tabTrackBrush:
				grid = obj_chain.trackChainGrid;
				break;
			case obj_panelPane.functionChainList_tabStackBrush:
				grid = obj_chain.stackChainGrid;
				break;
			case obj_panelPane.functionChainList_tabClique:
				grid = obj_chain.cliqueDisplayGrid;
				break;
			default:
				grid = obj_chain.rezChainGrid;
				break;
		}
		
		
		obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
		
		//show_message(ds_grid_height(grid));
		if(ds_grid_height(grid) > 0){
			var listOfWordID = ds_list_create();
			ds_list_copy(listOfWordID, ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, obj_control.selectedChainID));
		}

				switch (optionSelected)
				{
					//"Red", "Blue", "Green", "Gold", "Custom"
					case "Red":
						if( grid != obj_chain.stackChainGrid){
							for(var i = 0; i < ds_list_size(listOfWordID);i++){
								ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(255)));
							}
						}
						ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(255)));
						break;
						
					case "Blue":	
						if( grid != obj_chain.stackChainGrid){
							for(var i = 0; i < ds_list_size(listOfWordID);i++){
								ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(16711680)));
							}
						}
					ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(16711680)));
						break;
						
					case "Green":
						if( grid != obj_chain.stackChainGrid){
							for(var i = 0; i < ds_list_size(listOfWordID);i++){
								ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(65280)));
							}
						}
					ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(65280)));
						break;
						
					case "Gold":
					
						if( grid != obj_chain.stackChainGrid){
							for(var i = 0; i < ds_list_size(listOfWordID);i++){
								ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(4235000)));
							}
						}
					ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(4235000)));
						break;
						
					case "Custom":
					
						if (!obj_control.dialogueBoxActive) {
							keyboard_string = "";
							obj_control.recolor = true;
						}


						obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}
						
						break;
					default:
						break;
				}
		}
	}
}

else if (optionListType == 3)
{
	with (obj_panelPane)
	{
		if (currentFunction == functionChainList)
		{
			
			switch (optionSelected)
			{
				//"Red", "Blue", "Green", "Gold", "Custom"
				case "Swap":
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.swapLine = true;
					}


					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
				
					break;
						
				case "Shuffle":	
					obj_control.lineGridShuffle = !obj_control.lineGridShuffle;
					if (obj_control.lineGridShuffle) {
						scr_shuffleDisplayRows();
						scr_refreshLineGridDisplayRow(obj_control.lineGrid);
					}
					else {
						with(obj_panelPane) {
							functionSort_performSort = true;
						}
					}
						
					break;
				case "Toggle line #":
					
					obj_control.showLineNumber = !obj_control.showLineNumber;
					break;
						
				case "Reset Order":

					//ds_grid_copy(obj_control.unitGrid, obj_control.unitGridBackup);
					
					ds_grid_copy(obj_control.lineGrid, obj_control.lineGridBackup);
					
					break;
				
				case "Check Order":
					
					
					var tempLineGrid = ds_grid_create(ds_grid_width(obj_control.currentActiveLineGrid), ds_grid_height(obj_control.currentActiveLineGrid));
					ds_grid_copy(tempLineGrid, obj_control.currentActiveLineGrid);
					
					scr_gridMultiColSort(tempLineGrid, obj_control.lineGrid_colDiscoID, true, obj_control.lineGrid_colUnitStart, true, obj_control.lineGrid_colUnitEnd, true, obj_control.lineGrid_colUnitID, true);
					
					var checkList1 = ds_list_create();
					for (var i = 0; i < ds_grid_height(obj_control.currentActiveLineGrid); i++) {
						ds_list_add(checkList1, ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, i));
					}
					var checkList2 = ds_list_create();
					for (var i = 0; i < ds_grid_height(tempLineGrid); i++) {
						ds_list_add(checkList2, ds_grid_get(tempLineGrid, obj_control.lineGrid_colUnitID, i));
					}
					
					if(scr_compareLists(checkList1, checkList2)){
						show_message("Congratulations! The Conversation is back in order.");
					}
					else{
						show_message("Sorry! Some lines are still out of order.");
					}
					
					
					ds_list_destroy(checkList1);
					ds_list_destroy(checkList2);
					ds_grid_destroy(tempLineGrid);
					
				
					break;
						
				default:
					break;
			}
		}
	}
	
}
else if (optionListType == 4)
{
	// "Open File", "Save File", "Export Portion", "Change Author",  "Exit"
	switch (optionSelected)
	{
		case "Open File":
		//room_instance_clear(rm_mainScreen);
		//room_restart();
		
			show_message("Coming Soon");
			break;
		case "Save File":
		
			draw_set_alpha(1);
			draw_set_color(obj_toolPane.progressBarFrontColor);
			draw_rectangle(obj_toolPane.progressBarX, obj_toolPane.progressBarY, obj_toolPane.progressBarX + obj_toolPane.progressBarWidth, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight, false);
			draw_set_color(c_white);
			draw_set_font(obj_toolPane.progressBarFont);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			draw_text(obj_toolPane.progressBarX + 12, mean(obj_toolPane.progressBarY, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight), "Saving...");
			draw_set_font(fnt_dropDown);
		
			obj_fileLoader.ableToHotkey = false;
			
			with(obj_fileLoader){
				alarm[0] = 1;
			}
			
			//show_message("BUH 2");
			break;
		case "Export Portion":
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.ePressed = true;
			}

			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			//show_message("BUH 3");
			break;
		case "Change Author":
			show_message("Coming Soon");
			break;
		case "Exit":
		
		
			audio_stop_all();
	
			scr_userSettingsIniFile();
	
	
			if (!obj_control.allSaved and ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount) {
		
				if (os_type == os_macosx) {

					with (obj_fileLoader) {
						scr_saveREZ(false);
					}
		
				}
				else {
					if (show_question("Would you like to save before exiting?")) {
						with (obj_fileLoader) {
							scr_saveREZ(false);
						}
					}
				}
			}

			keyboard_string = "";
			room_goto(rm_openingScreen);
		
			//show_message("BUH 5");
			break;
		default:
			break;
	}
}
else if (optionListType == 5)
{
	 //"Clear Stacks", "Clear Rez Chains", "Clear Track Chains", "Clear Discourse", "Toggle Filter"
	switch (optionSelected)
	{
		case "Clear Stacks":
			show_message("Coming Soon");
			break;
		case "Clear Rez Chains":
			show_message("Coming Soon");
			break;
		case "Clear Track Chains":
			show_message("Coming Soon");
			break;
		case "Clear All Chains":
			show_message("Coming Soon");
			break;
		case "Toggle Filter Screen":
		
			if (obj_control.filterGridActive) {
				if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
					//obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList);
					//obj_control.prevCenterDisplayRow = ds_grid_get(obj_control.filterGrid, obj_control.lineGrid_colUnitID, obj_control.currentCenterDisplayRow);
					obj_control.scrollPlusYDest = obj_control.prevCenterDisplayRow;
					// Keep the focus on previous currentCenterDisplayRow
					//with (obj_control) {
					//	alarm[5] = 1;
					//}
				}
			
				// Switch to active grid
				obj_control.filterGridActive = false;
				obj_control.currentActiveLineGrid = obj_control.lineGrid;
			}
			else {
			
				obj_control.prevCenterDisplayRow = obj_control.scrollPlusYDest;
				// If filter is unactive. activate it
				with (obj_control) {
					scr_renderFilter();
				}
			}
			// Add to moveCounter
			obj_control.moveCounter ++;
		
			//show_message("BUH 5");
			break;
		default:
			break;
	}
}
else if (optionListType == 6)
{
	// "Hide Nav Window", "Increase Text Size", "Decrease Text Size", "Increase Column Size",  "Decrease Column Size","Increase Row Size", "Decrease Row Size"
	switch (optionSelected)
	{
		case "Toggle Nav Window":
			with(obj_panelPane){
				showNav = not showNav;	
			}
			//show_message("BUH 1");
			break;
		case "Increase Text Size":
		
			if (global.fontSize < 5) {
				global.fontSize++;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = true;
		
			//show_message("BUH 2");
			break;
		case "Decrease Text Size":
		
			if (global.fontSize > 0) {
				global.fontSize--;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = false;
			
			//show_message("BUH 3");
			break;
		case "Increase Column Size":
		
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal += 20;
			}
		
			//show_message("BUH 4");
			break;
		case "Decrease Column Size":
		
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal -= 20;
			}
		
			//show_message("BUH 5");
			break;
		case "Increase Row Size":
			
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			
			obj_control.gridSpaceVertical += 10;
			// Don't go above the max
			obj_control.gridSpaceVertical = min(obj_control.gridSpaceVertical, obj_control.gridSpaceVerticalMax);
			obj_control.lineSpacing += 4;
			obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
			// Multiply each line's pixelY by the new ratio
			ds_grid_multiply_region(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.lineGrid), obj_control.gridSpaceRatio);
			
			// If the search or filter grids are populated, then set their pixelY's as well
			if(searchGridPopulated) {
				ds_grid_multiply_region(obj_control.searchGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.searchGrid), obj_control.gridSpaceRatio);
			}
			if(filterGridPopulated) {
				ds_grid_multiply_region(obj_control.filterGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.filterGrid), obj_control.gridSpaceRatio);
			}
			// reset the ratio
			obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
		
			//show_message("BUH 4");
			break;
		case "Decrease Row Size":
		
			
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			
			obj_control.gridSpaceVertical -= 10;
			// Don't go above the max
			obj_control.gridSpaceVertical = max(obj_control.gridSpaceVertical, obj_control.gridSpaceVerticalMin);
			obj_control.lineSpacing -= 4;
			obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
			// Multiply each line's pixelY by the new ratio
			ds_grid_multiply_region(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.lineGrid), obj_control.gridSpaceRatio);
			
			// If the search or filter grids are populated, then set their pixelY's as well
			if(searchGridPopulated) {
				ds_grid_multiply_region(obj_control.searchGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.searchGrid), obj_control.gridSpaceRatio);
			}
			if(filterGridPopulated) {
				ds_grid_multiply_region(obj_control.filterGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.filterGrid), obj_control.gridSpaceRatio);
			}
			// reset the ratio
			obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
		
			//show_message("BUH 5");
			break;
		case "Toggle Dark Theme":
		
		
			global.colorTheme++;
			if (global.colorTheme >= ds_grid_height(global.colorThemeGrid)) {
				global.colorTheme = 0;
			}
	
			global.colorThemeBG = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colBG, global.colorTheme);
			global.colorThemeText = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colText, global.colorTheme);
			global.colorThemeSelected1 = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colSelected1, global.colorTheme);
			global.colorThemeSelected2 = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colSelected2, global.colorTheme);
			global.colorThemeBorders = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colBorders, global.colorTheme);
			global.colorThemePaneBG = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colPaneBG, global.colorTheme);
			global.colorThemeOutOfBounds = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colOutOfBounds, global.colorTheme);
			global.colorThemeHighlight = ds_grid_get(global.colorThemeGrid, global.colorThemeGrid_colHighlight, global.colorTheme);
	
			var layerID = layer_get_id("Background");
			var backID = layer_background_get_id(layerID);
			layer_background_blend(backID, global.colorThemeBG);
		
			//show_message("BUH 5");
			break;
		default:
			break;
	}
}
else if (optionListType == 7)
{
	// "Search For Words",  "Toggle Search Screen", "Clear Search Screen", "Find Next"
	switch (optionSelected)
	{
		case "Search For Words":
		
		
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.fPressed = true;
			}


			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}

		
			//show_message("BUH 1");
			break;
		case "Toggle Search Screen":
		
			if (ds_grid_height(obj_control.searchGrid) > 0 and !obj_control.gridView) {
				// Main/filter to search
				if(obj_control.currentActiveLineGrid == obj_control.lineGrid) {// or currentActiveLineGrid == filterGrid) {
					scr_unFocusAllChains();
					// Which grid are we switching from?
					obj_control.preSwitchLineGrid = obj_control.currentActiveLineGrid; 
					obj_control.searchGridActive = true;
					obj_control.currentActiveLineGrid = obj_control.searchGrid;
					// Which row are we switching from?
					obj_control.preSwitchDisplayRow = obj_control.scrollPlusYDest;//currentCenterDisplayRow; 
					obj_control.highlightedSearchRow = 0;
					//currentCenterDisplayRow = preSwitchSearchDisplayRow;
					obj_control.scrollPlusYDest  = obj_control.preSwitchSearchDisplayRow;
				//	var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, currentCenterDisplayRow);
					//obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(view_camera[0]) / 2) - 100;
		
					obj_control.wordLeftMarginDest = window_get_width() / 2;
				}
				// Switch back to either main or filter grids
				else if(obj_control.currentActiveLineGrid == obj_control.searchGrid) { 
					obj_control.searchGridActive = false;
		
					// Check to see which grid we're switching back into
					if(obj_control.preSwitchLineGrid == obj_control.filterGrid) {
						scr_renderFilter(); // Thankfully this script does a lot of work for us
					}
					else {
						obj_control.currentActiveLineGrid = obj_control.lineGrid;
					}
					obj_control.preSwitchSearchDisplayRow = obj_control.scrollPlusYDest;//currentCenterDisplayRow;
		
					// Make sure we don't try to render a line that doesn't exist
					if(obj_control.highlightedSearchRow > 0 && ds_grid_value_exists(obj_control.preSwitchLineGrid, 0, 0, 0, ds_grid_height(obj_control.preSwitchLineGrid), obj_control.highlightedSearchRow)){
						var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, obj_control.highlightedSearchRow);
						obj_control.preSwitchDisplayRow = -linePixelY + (camera_get_view_height(view_camera[0]) / 2) - 100;
					}
					//currentCenterDisplayRow = preSwitchDisplayRow;
					obj_control.scrollPlusYDest = obj_control.preSwitchDisplayRow;
		
					obj_control.wordLeftMarginDest = 170;
				}
			}
			//show_message("BUH 2");
			break;
		case "Clear Search Screen":
		
			show_message("Coming Soon");
			break;
		case "Find Next":
		
			show_message("Coming Soon");
			break;
		case "Jump To Time":
		
			scr_jumpToLineCalled();
			obj_control.goToTime = true;
			
			//show_message("BUH 5");
			break;
		case "Jump To Line":
		
			scr_jumpToLineCalled();
			
			//show_message("BUH 5");
			break;
		default:
			break;
	}
}


instance_destroy();