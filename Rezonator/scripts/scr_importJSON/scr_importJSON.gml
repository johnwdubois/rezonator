function scr_importJSON(argument0) {
	// Begin the import of a single user specified JSON file, usually a REZ file

	var filename = argument0;

	global.importCSVGrid = load_csv(filename);

	//show_message("done... width = " + string(ds_grid_width(global.importCSVGrid)) + ", height = " + string(ds_grid_height(global.importCSVGrid)));

	room_goto(rm_mainScreen);


}
