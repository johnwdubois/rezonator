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
	var previousClosestUnit = closestUnit;
	var disocurseSubMap = global.nodeMap[?global.discourseNode];
	var unitList = disocurseSubMap[?"unitList"];
	var displayUnitList = disocurseSubMap[?"displayUnitList"];
	var tokenList = disocurseSubMap[?"tokenList"];
	var unitListSize = ds_list_size(unitList);
	var currentPos = audioPos;
	/*
	for(var i = obj_control.drawRangeStart; i < obj_control.drawRangeEnd; i++){
		var currentUnit = displayUnitList[|i];
		if (is_string(currentUnit)) {
			var unitSubMap = global.nodeMap[?currentUnit];
			if (scr_isNumericAndExists(unitSubMap, ds_type_map)) {
				var unitStart = (scr_isStrNumeric(unitSubMap[? "unitStart"]))? real(unitSubMap[? "unitStart"]) : 0;
				var unitEnd = (scr_isStrNumeric(unitSubMap[? "unitEnd"]))? real(unitSubMap[? "unitEnd"]) : 0;
				if(is_real(unitStart) && is_real(unitEnd) && is_real(currentPos)){
					if(unitStart <= currentPos && unitEnd >= currentPos){
						closestUnit = currentUnit;
						var closestUnitSubMap = global.nodeMap[?closestUnit];
						var unitY = closestUnitSubMap[?"pixelY"]
						if(previousClosestUnit  != closestUnit && unitY > camera_get_view_height(view_camera[0])-windowHeight){
							scr_jumpToUnitTop(closestUnit);
						}
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
		}
	}
	*/
	
	if (closestUnit == "" && ds_list_size(unitList) >= 1) {
		closestUnit = unitList[| 0];
	}
	
	var closestUnitSubMap = global.nodeMap[? closestUnit];
	if (scr_isNumericAndExists(closestUnitSubMap, ds_type_map)) {
		var closestUnitStart = closestUnitSubMap[? "unitStart"];
		if (scr_isStrNumeric(closestUnitStart) || is_real(closestUnitStart)) {
			var closestUnitEnd = closestUnitSubMap[? "unitEnd"];
			if (scr_isStrNumeric(closestUnitEnd) || is_real(closestUnitEnd)) {
				closestUnitEnd = real(closestUnitEnd);
				
				// check if audio has progressed past this unit, and therefore we should check the next unit
				if (audioPos > closestUnitEnd) {
					
					var closestUnitIndex = ds_list_find_index(unitList, closestUnit);
					if (closestUnitIndex + 1 < ds_list_size(unitList)) {
						var nextUnit = unitList[| closestUnitIndex + 1];
						var nextUnitSubMap = global.nodeMap[? nextUnit];
					
						var nextUnitStart = nextUnitSubMap[? "unitStart"];
						if (scr_isStrNumeric(nextUnitStart) || is_real(nextUnitStart)) {
							nextUnitStart = real(nextUnitStart);
						
							// check if the audio has gotten to this unit's start time yet
							if (audioPos >= nextUnitStart) {
								closestUnit = nextUnit;
								//show_debug_message("closestUnit updated: " + string())
							}
						}
					}
				}
			}

		
		
			var unitY = closestUnitSubMap[?"pixelY"]
			if (previousClosestUnit != closestUnit && unitY > camera_get_view_height(view_camera[0])-windowHeight) {
				scr_jumpToUnitTop(closestUnit);
			}
			var unitLength = closestUnitEnd - closestUnitStart;
			var amountPlayed = currentPos - closestUnitStart;
			var unitEntryList = closestUnitSubMap[? "entryList"];
			var indexOfToken = floor((amountPlayed/unitLength) * ds_list_size(unitEntryList));
			var entrySubMap = global.nodeMap[?unitEntryList[|indexOfToken]];
			if(scr_isNumericAndExists(entrySubMap, ds_type_map)){
				closestToken = entrySubMap[?"token"];
				closestTokenIndex = ds_list_find_index(tokenList,closestToken);
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
