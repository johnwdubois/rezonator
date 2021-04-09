function scr_audioJumpToUnit(unitID) {
	
	show_debug_message("scr_audioJumpToUnit() ... unitID: " + string(unitID));
	
	// Set the position of the audio track based on the specified line's unit start time
	if (instance_exists(obj_audioUI)) {
		if (obj_audioUI.audioJumpOnWordClick) {
		
			if (unitID > 0 and unitID <= ds_grid_height(obj_control.unitGrid)) {
	
				var unitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, unitID - 1);
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
