var endLine = ds_grid_height(obj_control.lineGrid) - 1;
var fileNameNumber = 1;

splitSave = true;
global.fileSaveName = get_save_filename_ext("REZ file|*.rez", "", program_directory, "Save REZ");
var fileNumIndex = string_pos(".", global.fileSaveName);
var originalFileName = global.fileSaveName;
while (randLine2 <= endLine && randLine1 < endLine && fileNameNumber < 4){ 
	obj_fileLoader.subLineGridBeginning = randLine1;
	obj_fileLoader.subLineGridEnd = randLine2;

	global.stackGrabSave = true;

	//show_message(obj_fileLoader.subLineGridBeginning);
	//show_message(obj_fileLoader.subLineGridEnd);
	global.fileSaveName = string_insert(string(fileNameNumber++), originalFileName, fileNumIndex);
	//show_message(global.fileSaveName);
	
	draw_set_alpha(1);
	draw_set_color(obj_toolPane.progressBarFrontColor);
	draw_rectangle(obj_toolPane.progressBarX, obj_toolPane.progressBarY, obj_toolPane.progressBarX + obj_toolPane.progressBarWidth, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight, false);
	draw_set_color(c_white);
	draw_set_font(obj_toolPane.progressBarFont);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(obj_toolPane.progressBarX + 12, mean(obj_toolPane.progressBarY, obj_toolPane.progressBarY + obj_toolPane.progressBarHeight), "Saving...");
	draw_set_font(fnt_dropDown);
	
	scr_saveREZ(false);
	randLine1 = randLine2 + 1;
	randLine2 = randLine1 + floor(random(25)) + 1;
	//global.fileSaveName = global.fileSaveName + string(fileNameNumber++);
}
splitSave = false;