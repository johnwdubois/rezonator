/// @description autosave counter
global.autosaveTimer--;
if (global.autosaveTimer <= 0) {
	global.autosaveTimer = global.autosaveTimerFull;
	
	if (global.autosaveTimerFull > 0) {
		with (obj_fileLoader) {
			alarm[7] = 1;
		}
	}
}

alarm[4] = max(floor(fps), 10);