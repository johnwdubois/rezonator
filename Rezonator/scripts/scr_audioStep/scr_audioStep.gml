function scr_audioStep() {
	// drag to resize audio window
	if (point_in_rectangle(mouse_x, mouse_y, x, y - 5, x + windowWidth, y + 5)) {
		window_set_cursor(cr_size_ns);
	
		if (mouse_check_button_pressed(mb_left)) {
			windowResizeYHolding = true;
		}
	}
	if (!mouse_check_button(mb_left)) {
		windowResizeYHolding = false;
	}
	if (windowResizeYHolding) {
		y = clamp(mouse_y, obj_control.wordTopMargin + 200, camera_get_view_height(camera_get_active()) - 75);
		windowHeight = camera_get_view_height(camera_get_active()) - y;
	}
	else {
		y = clamp(y, obj_control.wordTopMargin + 200, camera_get_view_height(camera_get_active()) - 75);
		windowHeight = camera_get_view_height(camera_get_active()) - y;
	}


	// audio pausing
	if (audioPaused and audio_is_playing(audioSound)) {
		audio_pause_sound(audioSound);
	}
	if (!audioPaused and audio_is_paused(audioSound)) {
		audio_resume_sound(audioSound);
	}

	audioLength = audio_sound_length(audioSound);
	audioPos = audio_sound_get_track_position(audioSound);



	if (audioPos >= audioLength - 1) {
		audio_sound_set_track_position(audioSound, 0);
		audioPaused = true;
	}
	if(selectedStackGridRow > -1) { 
		if(stackUnitListSize > -1) {
			//show_debug_message("stackUnitListPosition: " + string(stackUnitListPosition));
			if(stackUnitListPosition <= stackUnitListSize - 1) {
				var currentUnit = ds_list_find_value(stackUnitList, stackUnitListPosition);
				var currentUnitEnd = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, currentUnit - 1);
				var currentUnitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentUnit - 1);
				
				
				if(audioPos >= currentUnitEnd) {
					if (stackUnitListPosition < stackUnitListSize - 1) {
						var nextUnit = ds_list_find_value(stackUnitList, stackUnitListPosition + 1);
						if(currentUnit != nextUnit - 1) {
							var nextUnitStartTime = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, nextUnit - 1);
							audio_sound_set_track_position(audioSound, nextUnitStartTime);
						}
					}
					stackUnitListPosition++;
				}
			}
			else if(stackUnitListPosition == stackUnitListSize) {
				stackUnitListPosition = 0;	
			}
		}
	}
	if(bookmarkEndTime > -1) { 
		if(audioPos >= bookmarkEndTime) {
			audioPaused = true;
		}
	}

	if(obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabStackBrush) {
		var currentStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0,  obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), obj_chain.chainStateFocus);
		if(currentStackRow > -1) {
			if(currentStackRow != selectedStackGridRow) {
				/*selectedStackGridRow = currentStackRow;
				bookmarkStartTime = -1;
				bookmarkEndTime = -1;
				selectedStackID = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, currentStackRow);
				stackUnitList = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colWordIDList, currentStackRow);
				stackUnitListSize = ds_list_size(stackUnitList);
				for(var unitTimeLoop = 0; unitTimeLoop < stackUnitListSize; unitTimeLoop++) {
					var currentUnit = ds_list_find_value(stackUnitList, unitTimeLoop);
					var currentUnitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentUnit - 1);
					var currentUnitEnd = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, currentUnit - 1);
					if(bookmarkStartTime == -1 or currentUnitStart < bookmarkStartTime) {
						bookmarkStartTime = currentUnitStart;
						stackStartUnit = currentUnit;
					}
					if(bookmarkEndTime == -1 or currentUnitEnd > bookmarkEndTime) {
						bookmarkEndTime = currentUnitEnd;
						stackEndUnit = currentUnit;
					}
				}
				stackUnitListPosition = 0;*/
				scr_audioStackUpdate(currentStackRow);
			}
			else {
				stackUnitList = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colWordIDList, selectedStackGridRow);
				if(stackStartUnit != ds_list_find_value(stackUnitList, 0)) {
					scr_audioStackUpdate(selectedStackGridRow);	
				}
				else if (stackEndUnit != ds_list_find_value(stackUnitList, ds_list_size(stackUnitList) - 1)) {
					scr_audioStackUpdate(selectedStackGridRow);
				}
			}
		}
		else {
			selectedStackGridRow = -1;	
			stackUnitList = -1;
			stackUnitListSize = -1;
			stackUnitListPosition = -1;
			selectedStackID = -1;
			//bookmarkStartTime = -1;
			//bookmarkEndTime = -1;
		}
	}
	else {
		selectedStackGridRow = -1;	
		stackUnitList = -1;
		stackUnitListSize = -1;
		stackUnitListPosition = -1;
		selectedStackID = -1;
		//bookmarkStartTime = -1;
		//bookmarkEndTime = -1;
	}
	/*if (selectedStackID != -1) {
		if(selectedStackID == ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, selectedStackGridRow)) {
			stackUnitList = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colWordIDList, selectedStackGridRow);
			if(stackStartUnit != ds_list_find_value(stackUnitList, 0)) {
				scr_audioStackUpdate(selectedStackGridRow);	
			}
			else if (stackEndUnit != ds_list_find_value(stackUnitList, ds_list_size(stackUnitList) - 1)) {
				scr_audioStackUpdate(selectedStackGridRow);
			}
		}
		else {
			var possibleNewStackGridRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0,  obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), selectedChainID);
			if(possibleNewStackGridRow > -1) {
				selectedStackGridRow = possibleNewStackGridRow;
			}
			else {
				selectedStackGridRow = -1;	
				stackUnitList = -1;
				stackUnitListSize = -1;
				stackUnitListPosition = -1;
				selectedStackID = -1;
				bookmarkStartTime = -1;
				bookmarkEndTime = -1;
			}
		}
	}*/
	
}
