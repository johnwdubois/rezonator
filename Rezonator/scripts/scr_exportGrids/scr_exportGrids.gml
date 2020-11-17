function scr_exportGrids() {
	// User will specify a name and a location for the CSV folder

	global.fileSaveName = get_save_filename_ext("CSV file|*.csv", string_lettersdigits(filename_name(global.fileSaveName)), program_directory, scr_get_translation("msg_save_csv"));
	// Check if the name is valid, or if the user exited the window
	if (global.fileSaveName == "" or global.fileSaveName == "undefined") {
		global.fileSaveName = "undefined";
		show_message(scr_get_translation("save_error"));
		exit;
	}

	var dirName = filename_path(global.fileSaveName) + string_lettersdigits(filename_name(global.fileSaveName));

	// Create the folder with the user created name
	if (not directory_exists(dirName)) {
		directory_create(dirName);
	}

	// Save the CSVs to the folder
	scr_gridToCSV(obj_control.wordGrid, dirName + "\\word.csv");
	scr_gridToCSV(obj_control.unitGrid, dirName + "\\unit.csv");
	//scr_gridToCSV(obj_control.dynamicWordGrid, dirName + "\\vizWord.csv");
	//scr_gridToCSV(obj_control.lineGrid, dirName + "\\line.csv");
	//scr_gridToCSV(obj_control.filterGrid, dirName + "\\filter.csv");
	//scr_gridToCSV(obj_control.searchGrid, dirName + "\\search.csv");
	//scr_gridToCSV(obj_control.hitGrid, dirName + "\\hit.csv");
	scr_gridToCSV(obj_chain.linkGrid, dirName + "\\link.csv");
	//scr_gridToCSV(obj_chain.vizLinkGrid, dirName + "\\vizLink.csv");
	scr_gridToCSV(obj_chain.cliqueGrid, dirName + "\\clique.csv");
	//scr_gridToCSV(obj_chain.cliqueDisplayGrid, dirName + "\\vizClique.csv");
	scr_gridToCSV(obj_chain.rezChainGrid, dirName + "\\rez.csv");
	scr_gridToCSV(obj_chain.trackChainGrid, dirName + "\\track.csv");
	scr_gridToCSV(obj_chain.stackChainGrid, dirName + "\\stack.csv");


}
