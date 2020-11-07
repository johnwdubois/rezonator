function scr_exportPortion(fullstring) {
	// Save a Rez file containing a user specified collection of lines


	// Safety check, make sure something was inputted
	if (string_length(fullstring) < 1) {
		exit;
	}

	// creating list of words if user inputed multiple words
	obj_control.listOfNumbers = ds_list_create();
	ds_list_copy( obj_control.listOfNumbers, scr_splitString(fullstring, ","));

	// check if user input more than two line numbers
	if (ds_list_size(obj_control.listOfNumbers) > 2) {
		show_message(scr_get_translation("msg_error_many_numbers"));
		exit;
	}

	// check if user input less than two line numbers
	if (ds_list_size(obj_control.listOfNumbers) <= 1) {
		show_message(scr_get_translation("msg_error_one_number"));
		exit;
	}

	// string( real( string_to_test ) ) == string( string_to_text )
	if (ds_list_find_value(obj_control.listOfNumbers, 0) == "" || ds_list_find_value(obj_control.listOfNumbers, 1) == "" ) {
		show_message(scr_get_translation("msg_error_invalid_number"));
		exit;
	}

	// make sure second number is bigger than the first
	if (real(string_digits(ds_list_find_value(obj_control.listOfNumbers, 0))) > real(string_digits(ds_list_find_value(obj_control.listOfNumbers, 1)))) {
		show_message(scr_get_translation("msg_error_first_lower"));
		exit;
	}



	obj_fileLoader.subLineGridBeginning = string_digits(ds_list_find_value(obj_control.listOfNumbers, 0));
	obj_fileLoader.subLineGridEnd = string_digits(ds_list_find_value(obj_control.listOfNumbers, 1));

	global.stackGrabSave = true;

	//show_message(obj_fileLoader.subLineGridBeginning);
	//show_message(obj_fileLoader.subLineGridEnd);



	var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
	instLoading.loadSprite = spr_saving;
	with(obj_fileLoader){
		alarm[0] = 2;
	}


}
