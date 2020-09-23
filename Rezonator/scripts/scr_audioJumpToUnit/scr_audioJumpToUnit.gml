function scr_audioJumpToUnit(argument0) {
	// Set the position of the audio track based on the specified line's unit start time

	if (instance_exists(obj_audioUI)) {
		if (obj_audioUI.audioJumpOnWordClick) {
		
			var unitID = argument0;
			if (unitID > 0 and unitID <= ds_grid_height(obj_control.unitGrid)) {
	
				var unitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, unitID - 1);
				unitStart = real(unitStart);
				//show_message("maybe");
				if (unitStart == undefined and unitStart > 0) {
					//show_message("its a number");
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
