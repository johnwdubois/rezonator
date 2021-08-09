function scr_audioJumpToUnit(unitID) {
	
	show_debug_message("scr_audioJumpToUnit() ... unitID: " + string(unitID));
	
	// Set the position of the audio track based on the specified line's unit start time
	if (instance_exists(obj_audioUI)) {
		if (obj_audioUI.audioJumpOnWordClick) {
		
			if (unitID != "" or unitID != undefined) {
				var unitSubMap = global.nodeMap[?unitID];
				if(!scr_isNumericAndExists(unitSubMap, ds_type_map)){exit;}
				
				var unitStart = unitSubMap[?"unitStart"];
				if(string_length(string_digits(unitStart)) < 1){exit;}
				unitStart = real(unitStart);
				
				if (unitStart != undefined and unitStart > 0) {
					with (obj_audioUI) {
						audioPos = unitStart;
						if (audioPos >= 0 and audioPos <= audioLength) {
							audio_sound_set_track_position(audioSound, audioPos);
						}
						else {
							audioPos = 0;
							audio_sound_set_track_position(audioSound, 0);
							audioPaused = true;
						}
					}
				}
			}
		}
	}


}
