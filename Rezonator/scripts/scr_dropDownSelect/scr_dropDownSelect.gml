
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
	instance_destroy();
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
		if(obj_control.selectedChainID == undefined){
			exit;
		}
		//show_message(ds_grid_height(grid));
		//show_message(obj_control.selectedChainID);
		if(ds_grid_height(grid) > 0 && grid != obj_chain.stackChainGrid){
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
							instance_destroy(obj_dropDown);
						break;
					case "Recolor":
						//show_message("Recolor chosen");
						
											
						obj_control.selectedChainID = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid) , 2 );
	
	
	
	
						var dropDownOptionList = ds_list_create();
						ds_list_add(dropDownOptionList, "Red", "Blue", "Green", "Gold", "Custom");
						
						if (ds_list_size(dropDownOptionList) > 0) {
							var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing  , -999, obj_dropDown);
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
						
							if (!instance_exists(obj_dialogueBox)) {
								instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
								obj_dialogueBox.clearChain = true;
								obj_dialogueBox.questionWindowActive = true;
							}
		
							
								instance_destroy(obj_dropDown);
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
							instance_destroy(obj_dropDown);
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
	instance_destroy();
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
				
				
					instance_destroy(obj_dropDown);
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
					instance_destroy(obj_dropDown);
					break;
				case "Toggle Line #":
					
					obj_control.showLineNumber = !obj_control.showLineNumber;
					break;
						
				case "Reset Order":

					//ds_grid_copy(obj_control.unitGrid, obj_control.unitGridBackup);
					
					ds_grid_copy(obj_control.lineGrid, obj_control.lineGridBackup);
					scr_refreshLineGridPixelY();
					scr_refreshLineGridDisplayRow(obj_control.lineGrid);
					instance_destroy(obj_dropDown);
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
					
					instance_destroy(obj_dropDown);
					break;
				case "Tag":
						
					var dropDownOptionList = ds_list_create();
					ds_list_add(dropDownOptionList, "Happy", "Sad", "Playful", "Serious", "Delete tag");
						
					if (ds_list_size(dropDownOptionList) > 0) {
						var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y+ obj_dropDown.optionSpacing*3, -999, obj_dropDown);
						dropDownInst.optionList = dropDownOptionList;
						dropDownInst.optionListType = 9;
					
						obj_control.ableToCreateDropDown = false;
						obj_control.alarm[0] = 2;
					}
					
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
		
		// destroy grid
		
		// get file name + extension
		
		// distinguish between rez or xml
		
		//room_restart();
		
			show_message("Coming Soon");
			break;
		case "Import Audio":

			with( obj_audioUI ){
			
				var getAudioFile = get_open_filename_ext("ogg file|*.ogg", "", working_directory, "Open a discourse ogg OGG file");
					if (getAudioFile != "" and file_exists(getAudioFile)) {
						audioFile = getAudioFile;
						audioStream = audio_create_stream(audioFile);
						audioSound = audio_play_sound(audioStream, 100, false);
						visible = true;
					}
			
			}

			//show_message("Coming Soon");
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
		case "Export CSV":
			
			draw_set_alpha(1);
			draw_set_color(obj_toolPane.progressBarFrontColor);
			draw_rectangle(obj_toolPane.progressBarX, obj_toolPane.progressBarY, obj_toolPane.progressBarX + obj_toolPane.progressBarWidth, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight, false);
			draw_set_color(c_white);
			draw_set_font(obj_toolPane.progressBarFont);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			draw_text(obj_toolPane.progressBarX + 12, mean(obj_toolPane.progressBarY, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight), "Exporting...");
			draw_set_font(fnt_dropDown);
		
			obj_fileLoader.ableToHotkey = false;
			
			with(obj_fileLoader){
				alarm[5] = 1;
			}
			
			break;
		case "Export Clip":
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
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.changeAuthor = true;
			}

			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
		
			//show_message("Coming Soon");
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
	instance_destroy();
}
else if (optionListType == 5)
{
	 //"Clear Stacks", "Clear Rez Chains", "Clear Track Chains", "Clear Discourse", "Toggle Filter"
	switch (optionSelected)
	{
		case "Delete All Stacks":
			

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllStacks = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		
			
		//	show_message("Coming Soon");
			break;
		case "Delete All Rez Chains":
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllRez = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		

			break;
		case "Delete All Track Chains":
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllTracks = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		
		
			//show_message("Coming Soon");
			break;
		case "Delete All Chains":
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllLinks = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		
			
			//show_message("Coming Soon");
			break;
		default:
			break;
	}
	instance_destroy();
}
else if (optionListType == 6)
{
	// "Hide Nav Window", "Increase Text Size", "Decrease Text Size", "Increase Column Size",  "Decrease Column Size","Increase Row Size", "Decrease Row Size"
	switch (optionSelected)
	{

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
		case "Increase Column Width":
		
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal += 20;
			}
		
			//show_message("BUH 4");
			break;
		case "Decrease Column Width":
		
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal -= 20;
			}
		
			//show_message("BUH 5");
			break;
		case "Increase Row Height":
			
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentCenterLine();
		
			if(obj_control.gridSpaceVertical < obj_control.gridSpaceVerticalMax) {
			
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
				scr_jumpToLine("", obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed < obj_control.arrowSpeedMax) {
					obj_control.arrowSpeed++;	
				}
			}
			//show_message("BUH 4");
			break;
		case "Decrease Row Height":
		
			
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentCenterLine();

			if(obj_control.gridSpaceVertical > obj_control.gridSpaceVerticalMin) {
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
				scr_jumpToLine("", obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed > obj_control.arrowSpeedMin) {
					obj_control.arrowSpeed--;	
				}
			
			}
			//show_message("BUH 5");
			break;
		case "Increase All":
		
			//verticle
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentCenterLine();
		
			if(obj_control.gridSpaceVertical < obj_control.gridSpaceVerticalMax) {
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
				scr_jumpToLine("", obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed < obj_control.arrowSpeedMax) {
					obj_control.arrowSpeed++;	
				}
			}
			
			//horizontal
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal += 20;
			}
			
			//Text
			
				
			if (global.fontSize < 5) {
				global.fontSize++;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = true;
			
			break;
		case "Decrease All":
			
			//Verticle
						
			var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
			var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			obj_control.prevCenterDisplayRow = scr_currentCenterLine();

			if(obj_control.gridSpaceVertical > obj_control.gridSpaceVerticalMin) {
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
				scr_jumpToLine("", obj_control.prevCenterDisplayRow);
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
				if(obj_control.arrowSpeed > obj_control.arrowSpeedMin) {
					obj_control.arrowSpeed--;	
				}
			}
			
			
			//Horizontal			
			if (!obj_control.gridView) {
				obj_control.gridSpaceHorizontal -= 20;
			}
		
			//TEXT
					
			if (global.fontSize > 0) {
				global.fontSize--;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = false;
			
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
		case "Toggle Nav Window":
			with(obj_panelPane){
				showNav = not showNav;	
				
			}
			obj_toolPane.showTool = !obj_toolPane.showTool;
			//show_message("BUH 1");
			break;
/*
		case "Start StackShow":
			if(obj_control.currentStackShowListPosition == -1) {
				obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
				// Instantiate the screen for users to select which stacks go in the stackShow

				if (!instance_exists(obj_stackShow)) {
					instance_create_layer(x, y, "InstancesAudio", obj_stackShow);
				}
					obj_control.stackShowWindowActive = true;
			}
			break;
*/
		case "Toggle Grid View":
		obj_control.gridView = !obj_control.gridView;
			break;		
		case "Toggle Filter Screen":
		
			if (obj_control.filterGridActive) {
				if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
					//obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList);
					//obj_control.prevCenterYDest = ds_grid_get(obj_control.filterGrid, obj_control.lineGrid_colUnitID, obj_control.currentCenterDisplayRow);
					obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
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
			
				obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
				// If filter is unactive. activate it
				with (obj_control) {
					scr_renderFilter();
				}
			}
			// Add to moveCounter
			obj_control.moveCounter ++;
		
			//show_message("BUH 5");
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
		
					//obj_control.wordLeftMarginDest = 170;
					with (obj_alarm) {
						alarm[0] = 5;
					}
				}
				
			}
			//show_message("BUH 2");
			break;
		case "Toggle Transcript View":
			obj_control.wordTranscriptView = !obj_control.wordTranscriptView;
			
		for (var i = 0; i < ds_grid_height(obj_control.dynamicWordGrid); i++) {
			var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, i);
			var currentWordToken = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, i);
			var currentReplaceWord = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord, i);
	
			if (string_length(currentReplaceWord) > 0) {
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentReplaceWord);
			}
			else {
				if (obj_control.wordTranscriptView) {
					ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentWordToken);
				}
				else {
					ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentWordTranscript);
				}
			}
	
			if (string_length(currentWordToken) < 1) {
				var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, i);
				if (currentWordState == obj_control.wordStateNormal) {
					ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, i, obj_control.wordStateDead);
				}
				else if (currentWordState == obj_control.wordStateDead) {
					ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, i, obj_control.wordStateNormal);
				}
			}
		}
		default:
			break;
	}
	instance_destroy();
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

		case "Clear Search Screen":
					
					
			ds_grid_copy(obj_control.searchGrid, obj_control.emptySearchGrid);
			ds_grid_copy( obj_control.hitGrid,obj_control.emptyHitGrid);
			
			
			obj_control.searchGridActive = false;
			obj_control.filterGridActive = false;
			obj_control.currentActiveLineGrid = obj_control.lineGrid;
			//obj_control.preSwitchSearchDisplayRow = obj_control.scrollPlusYDest;
			//obj_control.scrollPlusYDest = obj_control.preSwitchDisplayRow;
			
			//show_message("Coming Soon");
			break;
		case "Go To Time":
		
			scr_jumpToLineCalled();
			obj_control.goToTime = true;
			
			//show_message("BUH 5");
			break;
		case "Go To Line":
		
			scr_jumpToLineCalled();
			
			//show_message("BUH 5");
			break;
		default:
			break;
	}
	instance_destroy();
}
//right click on word options
else if (optionListType == 8)
{
	// "Hide Nav Window", "Increase Text Size", "Decrease Text Size", "Increase Column Size",  "Decrease Column Size","Increase Row Size", "Decrease Row Size"
	switch (optionSelected)
	{
		/*
		case "Link":
		
			
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Create Rez", "Create track", "Delete link");
			
			if (ds_list_size(dropDownOptionList) > 0) {
				
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y, -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 9;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}

			//show_message("BUH 1");
			break;
			*/
		case "Tag":
				
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Create tag", "Edit Tag", "Delete tag");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y+ obj_dropDown.optionSpacing*4, -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 9;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}

			//show_message("BUH 2");
			break;
		case "Replace Word":
		
			if (obj_control.rightClickWordID > -1 and obj_control.rightClickWordID  < ds_grid_height(obj_control.wordGrid)) {
				//show_message("buh");
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.replace = true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
		
			}
			obj_control.rightClickonWord = false;
			instance_destroy();
			//show_message("BUH 1");
			break;
		case "Restore Word":
		
			if (obj_control.rightClickWordID > -1 and obj_control.rightClickWordID  < ds_grid_height(obj_control.wordGrid)) {
				if(!obj_control.wordTranscriptView){
					var originalWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, obj_control.rightClickWordID - 1);
				}
				else{
					var originalWord = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, obj_control.rightClickWordID - 1);
				}
		
			scr_replaceWord( obj_control.rightClickWordID , originalWord);
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord , obj_control.rightClickWordID - 1, "");
			}
			obj_control.rightClickonWord = false;
			instance_destroy();
			//show_message("BUH 1");
			break;
		case "Split Word":

			if (obj_control.rightClickWordID > -1 and obj_control.rightClickWordID  < ds_grid_height(obj_control.wordGrid)) {
				//show_message("buh");
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.replace = true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;
					obj_control.splitWord = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						
					}
		
			}
			obj_control.rightClickonWord = false;
			instance_destroy();
			//show_message("BUH 2");
			break;
		case "New Word":
		
		
		
						var dropDownOptionList = ds_list_create();
						ds_list_add(dropDownOptionList, "<0>", "<ZERO>", "<PRO>", "Custom");
						
						if (ds_list_size(dropDownOptionList) > 0) {
							var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing*3  , -999, obj_dropDown);
							dropDownInst.optionList = dropDownOptionList;
							dropDownInst.optionListType = 11;
					
							obj_control.ableToCreateDropDown = false;
							obj_control.alarm[0] = 2;
						}
	
		
		

			//show_message("BUH 3");
			break;
		case "Delete New Word":
			obj_control.newWordHoverWordID = obj_control.rightClickWordID;
			obj_control.deleteNewWord =true;
			//show_message("Coming Soon");
			scr_deleteFromChain();
			
			obj_control.deleteNewWord = false;
			obj_control.rightClickonWord = false;
			instance_destroy();
	
			break;
		case "Delete Link":
			/*
			var currentInChainList = ds_list_create();
			ds_list_copy(currentInChainList, ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList,obj_control.rightClickWordID - 1) );
			if(obj_toolPane.currentMode == obj_toolPane.modeRez){
				var chainGridRowToSet = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID,0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), ds_list_find_value(currentInChainList,0));
				ds_grid_set(obj_chain.rezChainGrid,obj_chain.chainGrid_colChainState, chainGridRowToSet, 2);
			}
			else if(obj_toolPane.currentMode == obj_toolPane.modeTrack){
				var chainGridRowToSet = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID,0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.trackChainGrid), ds_list_find_value(currentInChainList,0));
				ds_grid_set(obj_chain.trackChainGrid,obj_chain.chainGrid_colChainState, chainGridRowToSet, 2);
			}
			else{
				break;
			}
			*/
			var rowToSet = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colSource, 0, obj_chain.linkGrid_colSource, ds_grid_height(obj_chain.linkGrid),  obj_control.rightClickWordID);
			ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowToSet, 1);
				
			scr_deleteFromChain();
			instance_destroy();
			break;
		case "Delete Chunk":

			//obj_control.newWordHoverWordID = obj_control.rightClickWordID;
			obj_control.deleteChunkWord = true;
			//show_message("Coming Soon");
			scr_deleteFromChain();
			
			obj_control.deleteChunkWord = false;
			obj_control.rightClickonWord = false;
			instance_destroy();
			break;
			/*
		case "Recolor":
		
	
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Red", "Blue", "Green", "Gold", "Custom");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing * 3 , -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 12;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}

			//show_message("BUH 4");
			break;
			*/
			
		default:
			break;
	}


}
else if (optionListType == 9)
{
	// "Hide Nav Window", "Increase Text Size", "Decrease Text Size", "Increase Column Size",  "Decrease Column Size","Increase Row Size", "Decrease Row Size"
	//"Create Rez", "Create track", "Delete rez", "Delete track"
	switch (optionSelected)
	{
		//"Happy", "Sad", "Playful", "Serious",
		case "Happy":
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colTag, obj_control.swapLinePos1-1, "Happy");
			break;
		case "Sad":
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colTag, obj_control.swapLinePos1-1, "Sad");
			break;
		case "Playful":
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colTag, obj_control.swapLinePos1-1, "Playful");
			break;
		case "Serious":
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colTag, obj_control.swapLinePos1-1, "Serious");
			break;
		case "Delete tag":
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colTag, obj_control.swapLinePos1-1, 0);
			break;
		default:
			break;
	}
	with(obj_dropDown){
		instance_destroy();
	}
	obj_control.rightClickonWord = false;
}

else if (optionListType == 10)
{

	switch (optionSelected)
	{
		case "Present":
			obj_stackShow.currentGame = "Present";
			break;
		case "Where's Elmo":
			obj_stackShow.currentGame = "Where's Elmo";
			break;
		case "Rezzles":	
			obj_stackShow.currentGame = "Rezzles";
			break;
		case "SpotBot":
			obj_stackShow.currentGame = "SpotBot";
			break;
		default:
			break;
	}
	with(obj_dropDown){
		instance_destroy();
	}
}

else if (optionListType == 11)
{

	switch (optionSelected)
	{
		case "<0>":
			obj_control.newWordPre1 = true;
			obj_control.currentNewWordPre = 1;
			if (device_mouse_check_button_released(0, mb_left) and not obj_control.dialogueBoxActive) {				
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.newWordCreated =true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}

			}
			obj_control.rightClickonWord = false;
			instance_destroy();
			break;
		case "<ZERO>":
			obj_control.newWordPre2 = true;
			obj_control.currentNewWordPre = 2;
			if (device_mouse_check_button_released(0, mb_left) and not obj_control.dialogueBoxActive) {				
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.newWordCreated =true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}

			}
			obj_control.rightClickonWord = false;

			break;
		case "<PRO>":	
			obj_control.currentNewWordPre = 3;
			obj_control.newWordPre3 = true;
			if (device_mouse_check_button_released(0, mb_left) and not obj_control.dialogueBoxActive) {				
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.newWordCreated =true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}

			}
			obj_control.rightClickonWord = false;

			break;
		case "Custom":
			obj_control.currentNewWordPre = 4;
			if (device_mouse_check_button_released(0, mb_left) and not obj_control.dialogueBoxActive) {				
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.newWordCreated =true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;

						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						}

			}
			obj_control.rightClickonWord = false;

			break;
		default:
			break;
	}
	with(obj_dropDown){
		instance_destroy();
	}
}



