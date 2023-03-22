/// @description Save Random Portions
var endLine = ds_grid_height(obj_control.lineGrid) - 1;
var fileNameNumber = 1;


global.fileSaveName = get_save_filename_ext("REZ file|*.rez", "", program_directory, "Save REZ");

var fileNumIndex = string_pos(".", global.fileSaveName);
var originalFileName = global.fileSaveName;
while (randLine2 <= endLine && randLine1 < endLine && fileNameNumber < 4) { 
	obj_fileLoader.subLineGridBeginning = randLine1;
	obj_fileLoader.subLineGridEnd = randLine2;

	global.stackGrabSave = true;

	global.fileSaveName = string_insert(string(fileNameNumber++), originalFileName, fileNumIndex);

	var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingBar);
	instLoading.loadSprite = spr_saving;
	with (obj_fileLoader) {
		alarm[0] = 2;
	}
	randLine1 = randLine2 + 1;
	randLine2 = randLine1 + floor(random(7)) + 1;
	//global.fileSaveName = global.fileSaveName + string(fileNameNumber++);
}
splitSave = false;
randLine1 = 1;
randLine2 = randLine1 + floor(random(7)) + 1;