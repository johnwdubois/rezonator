/// @description load backup linegrid when opening file
// You can write your code in this editor

ds_grid_copy(obj_control.lineGridBackup, obj_control.lineGrid);




var userSettingsList = ds_list_create();

if (directory_exists(global.rezonatorDirString)) {
	if (os_type == os_macosx) {
		var filename = global.rezonatorDirString + "/~usersettings.ini";
	}
	else {
		var filename = global.rezonatorDirString + "\\~usersettings.ini";
	}
	
	if (file_exists(filename)) {

		var file = file_text_open_read(filename);
		
		while (!file_text_eof(file)) {
			ds_list_add(userSettingsList, file_text_readln(file));
		}
		
		file_text_close(file);
	}
}

global.iniFileString = scr_getStringOfList(userSettingsList);
ds_list_destroy(userSettingsList);

var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
var filterGridPopulated = ds_grid_height(obj_control.filterGrid);

if (string_count("lineHeight:", global.iniFileString) > 0) {
	obj_control.gridSpaceVertical = real(scr_getValueFromString(global.iniFileString, "lineHeight:", ","));
	if (string_count("columnWidth:", global.iniFileString) > 0) {
		obj_control.gridSpaceHorizontal = real(scr_getValueFromString(global.iniFileString, "columnWidth:", ","));
	}
				obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
			
			// Multiply each line's pixelY by the new ratio
			ds_grid_multiply_region(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.lineGrid), obj_control.gridSpaceRatio);
			
			// If the search or filter grids are populated, then set their pixelY's as well
			if(searchGridPopulated) {
				ds_grid_multiply_region(obj_control.searchGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.searchGrid), obj_control.gridSpaceRatio);
			}
			if(filterGridPopulated) {
				ds_grid_multiply_region(obj_control.filterGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.filterGrid), obj_control.gridSpaceRatio);
			}
			// reset the ratio
			obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
	
	//obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical ;
}

if (string_count("fontSize:", global.iniFileString) > 0) {
	global.fontSize = real(scr_getValueFromString(global.iniFileString, "fontSize:", ","));
}

scr_fontGlobalUpdate();



/*
show_message(string(real(scr_getValueFromString(global.iniFileString, "SpeakerLabelX3:", ","))));
show_message(string(real(scr_getValueFromString(global.iniFileString, "SpeakerLabelX4:", ","))));

show_message(scr_getStringOfList(obj_control.speakerLabelColXList));


if (string_count("SpeakerLabelX3:", global.iniFileString) > 0) {
	ds_list_replace( obj_control.speakerLabelColXList, 2, real(scr_getValueFromString(global.iniFileString, "SpeakerLabelX3:", ",")));
}

if (string_count("SpeakerLabelX4:", global.iniFileString) > 0) {
	ds_list_replace( obj_control.speakerLabelColXList, 3, real(scr_getValueFromString(global.iniFileString, "SpeakerLabelX4:", ",")));
}
*/
scr_setSpeakerLabelColWidth();
//show_message(scr_getStringOfList(obj_control.speakerLabelColXList));