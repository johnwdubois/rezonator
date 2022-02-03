/*
	Purpose: Check for window resizing, play/pause, and bookmarks set by stacks
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
	
	var disocurseSubMap = global.nodeMap[?global.discourseNode];
	var unitList = disocurseSubMap[?"unitList"];
	var tokenList = disocurseSubMap[?"tokenList"];
	var unitListSize = ds_list_size(unitList);
	var currentPos = audioPos;
	for(var i = 0; i < unitListSize; i++){
		var currentUnit = unitList[|i];
		var unitSubMap = global.nodeMap[?currentUnit];
		var unitStart = (scr_isStrNumeric(unitSubMap[? "unitStart"]))? real(unitSubMap[? "unitStart"]) : 0;
		var unitEnd = (scr_isStrNumeric(unitSubMap[? "unitEnd"]))? real(unitSubMap[? "unitEnd"]) : 0;
		if(is_real(unitStart) && is_real(unitEnd) && is_real(currentPos)){
			if(unitStart <= currentPos && unitEnd >= currentPos){
				closestUnit = currentUnit;
				var unitLength = unitEnd - unitStart;
				var amountPlayed = currentPos - unitStart;
				var unitEntryList = unitSubMap[? "entryList"];
				var indexOfToken = floor((amountPlayed/unitLength) * ds_list_size(unitEntryList));
				var entrySubMap = global.nodeMap[?unitEntryList[|indexOfToken]];
				if(scr_isNumericAndExists(entrySubMap, ds_type_map)){
					closestToken = entrySubMap[?"token"];
					closestTokenIndex = ds_list_find_index(tokenList,closestToken);
				}
			}
		}
	}
	
	
	// Pause audio at end of track
	if (audioPos >= audioLength - 1) {
		audio_sound_set_track_position(audioSound, 0);
		audioPaused = true;
	}
	
	// Pause audio at Endmark
	if(bookmarkEndTime > -1) { 
		if(audioPos >= bookmarkEndTime) {
			audioPaused = true;
		}
	}
	
}
