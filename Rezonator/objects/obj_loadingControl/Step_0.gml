scr_windowExit();


if (keyboard_check_released(vk_escape)) {
	show_debug_message("Going to openingScreen, obj_loadingControl step");
	room_goto(rm_openingScreen);
}


if (importGridRow >= ds_grid_height(global.importGrid) && !finished) {
	finished = true;
	show_debug_message("obj_loadingControl ... finished!" + scr_printTime());
	
	// copy unitList into displayUnitList
	ds_list_copy(displayUnitList, unitList);

	room_goto(rm_mainScreen);
}
else {
	var iterations = fps;
	if (global.importType == global.importType_PlainText || global.importType == global.importType_Paragraph) {
		repeat(iterations) scr_importGridToNodeMap_plainText(importGridRow);
	}
	else if (global.importType == global.importType_IGT || global.importType == global.importType_Transcription || global.importType == global.importType_TabDelimited) {
		repeat(iterations) scr_importGridToNodeMap_fieldsRowUnit(importGridRow);
	}
	else if (global.importType == global.importType_CoNLLU || global.importType == global.importType_CSV) {
		repeat(iterations) scr_importGridToNodeMap_fieldsRowToken(importGridRow);
	}
}