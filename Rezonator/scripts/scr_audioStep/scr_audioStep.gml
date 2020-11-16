/*
	scr_audioStep();
	
	Last Updated: 2020-10-26
	
	Called from: obj_audioUI
	
	Purpose: Check for window resizing, play/pause, and bookmarks set by stacks
	
	
	Author: Terry DuBois, Georgio Klironomos
*/
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

	// Pause audio at end of track
	if (audioPos >= audioLength - 1) {
		audio_sound_set_track_position(audioSound, 0);
		audioPaused = true;
	}
	
	//Play through audio of Stack with line interuptions
	if(selectedStackGridRow > -1) { 
		if(stackUnitListSize > -1) {
			if(stackUnitListPosition <= stackUnitListSize - 1) {
				var currentUnit = ds_list_find_value(stackUnitList, stackUnitListPosition);
				var currentUnitEnd = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, currentUnit - 1);
				var currentUnitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentUnit - 1);
				
				// Jump audio to next unit if necessary
				if(audioPos >= currentUnitEnd) {
					if (stackUnitListPosition < stackUnitListSize - 1) {
						var nextUnit = ds_list_find_value(stackUnitList, stackUnitListPosition + 1);
						if(currentUnit != nextUnit - 1) {
							var nextUnitStartTime = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, nextUnit - 1);
							audio_sound_set_track_position(audioSound, nextUnitStartTime);
							// Giorgia has requested a feature to wait 1 second before jumping to a non-sequetial unit
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
	
	// Pause audio at Endmark
	if(bookmarkEndTime > -1) { 
		if(audioPos >= bookmarkEndTime) {
			audioPaused = true;
		}
	}
	
	// Update the Stack audio Bookmark and endmark if the selected stack has changed
	if(obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabStackBrush) {
		var currentStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0,  obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), obj_chain.chainStateFocus);
		if(currentStackRow > -1) {
			if(currentStackRow != selectedStackGridRow) {
				
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
			stackUnfocus = false;
		}
		else {
			selectedStackGridRow = -1;	
			stackUnitList = -1;
			stackUnitListSize = -1;
			stackUnitListPosition = -1;
			selectedStackID = -1;
			if(!stackUnfocus) {
				bookmarkStartTime = -1;
				bookmarkEndTime = -1;
				stackUnfocus = true;
			}
		}
	}
	else {
		selectedStackGridRow = -1;	
		stackUnitList = -1;
		stackUnitListSize = -1;
		stackUnitListPosition = -1;
		selectedStackID = -1;
		if(!stackUnfocus) {
			bookmarkStartTime = -1;
			bookmarkEndTime = -1;
			stackUnfocus = true;
		}
	}
}
