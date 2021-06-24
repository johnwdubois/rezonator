fileLoadRate = ceil(fps);

if (not inititalAutosave) {
	if (!file_exists(global.fileSaveName)) {
		alarm[1] = 1;
		inititalAutosave = true;
		ds_grid_copy(obj_control.lineGridBackup, obj_control.lineGrid);
	}
	else {
		alarm[1] = 36000;
		inititalAutosave = true;
	}
}

var loadCSVRate = fileLoadRate / 8;
if (fps < 50) {
	loadCSVRate = 5;
	if (fps < 40) {
		loadCSVRate = 4;
		if (fps < 30) {
			loadCSVRate = 3;
		}
	}
}






