function scr_exportClip(fullstring) {
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
	
	var firstNumStr = string_digits(obj_control.listOfNumbers[| 0]);
	var secondNumStr = string_digits(obj_control.listOfNumbers[| 1]);

	// string( real( string_to_test ) ) == string( string_to_text )
	if (firstNumStr == "" || secondNumStr == "") {
		show_message(scr_get_translation("msg_error_invalid_number"));
		exit;
	}
	
	var firstNumReal = real(firstNumStr);
	var secondNumReal = real(secondNumStr);

	// make sure second number is bigger than the first
	if (firstNumReal > secondNumReal || firstNumReal < 0 || secondNumReal < 0) {
		show_message(scr_get_translation("msg_error_first_lower"));
		exit;
	}
	
	
	
	// get unit list
	var clipUnitList = ds_list_create();
	var docSubMap = global.nodeMap[? global.discourseNode];
	if (scr_isNumericAndExists(docSubMap, ds_type_map)) {
		var unitList = docSubMap[? "unitList"];
		if (scr_isNumericAndExists(unitList, ds_type_list)) {
			var unitListSize = ds_list_size(unitList);
			
			if (firstNumReal < unitListSize && secondNumReal < unitListSize) {
				for (var i = firstNumReal; i < secondNumReal; i++) {
					ds_list_add(clipUnitList, unitList[| i]);
				}
			}
		}
	}
	
	if (ds_list_size(clipUnitList) > 0) {
		scr_miniClipFile(clipUnitList);
	}


	var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
	instLoading.loadSprite = spr_saving;
	with(obj_fileLoader){
		alarm[0] = 2;
	}


}
