function scr_clipFromStack(selectedStackID) {
	/*// Save a Rez file containing a user specified collection of lines

	var fullstring = argument0;

	// Safety check, make sure something was inputted
	if (string_length(fullstring) < 1) {
		exit;
	}

	// creating list of words if user inputed multiple words
	obj_control.listOfNumbers = ds_list_create();
	ds_list_copy( obj_control.listOfNumbers, scr_splitString(fullstring, ","));

	// check if user input more than two line numbers
	if (ds_list_size(obj_control.listOfNumbers) > 2) {
		show_message("too many numbers inputed, please input two unique line numbers");
		exit;
	}

	// check if user input less than two line numbers
	if (ds_list_size(obj_control.listOfNumbers) <= 1) {
		show_message("only one number inputed, please input two unique line numbers");
		exit;
	}

	// string( real( string_to_test ) ) == string( string_to_text )
	if (ds_list_find_value(obj_control.listOfNumbers, 0) == "" || ds_list_find_value(obj_control.listOfNumbers, 1) == "" ) {
		show_message("one of your numbers is invalid");
		exit;
	}

	// make sure second number is bigger than the first
	if (real(string_digits(ds_list_find_value(obj_control.listOfNumbers, 0))) > real(string_digits(ds_list_find_value(obj_control.listOfNumbers, 1)))) {
		show_message("first number must be lower than the second");
		exit;
	}
	*/
	var unitIDList = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colWordIDList, selectedStackID);
	var firstUnitInStack = ds_list_find_value(unitIDList, 0);
	var lastUnitInStack = ds_list_find_value(unitIDList, ds_list_size(unitIDList) - 1);
	
	//show_message(firstUnitInStack);
	//show_message(lastUnitInStack);
	

	obj_fileLoader.subLineGridBeginning = string_digits(firstUnitInStack);//ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), firstUnitInStack));
	obj_fileLoader.subLineGridEnd = string_digits(lastUnitInStack);//ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), lastUnitInStack));

	global.stackGrabSave = true;

	//show_message(obj_fileLoader.subLineGridBeginning);
	//show_message(obj_fileLoader.subLineGridEnd);



	var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
	instLoading.loadSprite = spr_saving;
	with(obj_fileLoader){
		alarm[0] = 2;
	}


}
