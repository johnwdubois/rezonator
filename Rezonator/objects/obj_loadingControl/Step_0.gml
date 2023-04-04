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
	scr_addToListOnce(global.usedImports,global.importType);
	if (STEAMAPI) {
		var currentUsedImports = steam_get_stat_int("SA_imports");
		var usedImportSize = ds_list_size(global.usedImports);
		if (usedImportSize > currentUsedImports) {
			steam_set_stat_int("SA_imports",usedImportSize);
			if (steam_get_stat_int("SA_imports") >= 7 ) {
				if (!steam_get_achievement("SA_all-impots")) {
					steam_set_achievement("SA_all-impots");
				}
			}
		}
	}
	room_goto(rm_mainScreen);
}
else {
	var iterations = floor(fps);
	if (global.importType == IMPORTTYPE_SONG || global.importType == IMPORTTYPE_PROSE) {
		repeat(iterations) scr_importGridToNodeMap_plainText(importGridRow);
	}
	else if (global.importType == IMPORTTYPE_IGT || global.importType == IMPORTTYPE_TRANSCRIPTION || global.importType == IMPORTTYPE_ELAN || global.importType == IMPORTTYPE_AICHAT) {
		repeat(iterations) scr_importGridToNodeMap_fieldsRowUnit(importGridRow);
	}
	else if (global.importType == IMPORTTYPE_CONLLU || global.importType == IMPORTTYPE_WORD) {
		repeat(iterations) scr_importGridToNodeMap_fieldsRowToken(importGridRow);
	}
}