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
	if(selectedStack > -1) { 
		if(audioPos >= stackEndTime) {
			audioPaused = true;
		}
	}

	if(obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabStackBrush) {
		var currentStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0,  obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), obj_chain.chainStateFocus);
		if(currentStackRow > -1) {
			if(currentStackRow != selectedStack) {
				selectedStack = currentStackRow;
				var currentUnitList = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colWordIDList, currentStackRow);
				var currentUnitListSize = ds_list_size(currentUnitList);
				for(var unitTimeLoop = 0; unitTimeLoop < currentUnitListSize; unitTimeLoop++) {
					var currentUnit = ds_list_find_value(currentUnitList, unitTimeLoop);
					var currentUnitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentUnit - 1);
					var currentUnitEnd = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, currentUnit - 1);
					if(stackStartTime == -1 or currentUnitStart < stackStartTime) {
						stackStartTime = currentUnitStart;
						stackStartUnit = currentUnit;
					}
					if(stackEndTime == -1 or currentUnitEnd > stackEndTime) {
						stackEndTime = currentUnitEnd;
						stackEndUnit = currentUnit;
					}
				}
			}
		}
		else {
			selectedStack = -1;	
			stackStartTime = -1;
			stackEndTime = -1;
		}
	}
	else {
		selectedStack = -1;	
		stackStartTime = -1;
		stackEndTime = -1;
	}
	
}
