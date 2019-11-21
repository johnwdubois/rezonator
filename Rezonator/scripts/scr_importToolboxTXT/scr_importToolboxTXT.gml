var filename = argument0;

var fileOpenRead = file_text_open_read(filename);

while (not file_text_eof(fileOpenRead)) {
	
	var lineInFile = file_text_readln(fileOpenRead);
	if (string_length(string_letters(lineInFile)) < 1) {
		continue;
	}
	if (string_char_at(lineInFile, 1) != "\\") {
		continue;
	}
	
	var lineInFileTrim = "";
	if (string_count("\\ref ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\ref "));
		ds_grid_resize(global.importToolboxGrid, global.importToolboxGridWidth, ds_grid_height(global.importToolboxGrid) + 1);
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colRef, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\ELANBegin ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\ELANBegin "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colELANBegin, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\ELANEnd ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\ELANEnd "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colELANEnd, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\ELANParticipant ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\ELANParticipant "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colELANParticipant, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\tx ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\tx "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colTx, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\gw ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\gw "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colGw, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\mph ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\mph "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colMph, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\mgl ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\mgl "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colMgl, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\lg ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\lg "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colLg, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\id ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\id "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colId, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\ps ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\ps "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colPs, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\eng ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\eng "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colEng, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\nep ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\nep "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colNep, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}
	else if (string_count("\\dt ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\dt "));
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colDt, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
	}

}


room_goto(rm_mainScreen);