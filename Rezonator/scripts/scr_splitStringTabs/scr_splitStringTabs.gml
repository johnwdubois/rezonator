function scr_splitStringTabs() {



	// scr_splitString(:string, delimiter:string, ?list<string>):list<string>
	var oldString = argument[0];
	var delimiter = argument[1];
	var newList;
	//var finalList = ds_list_create();
	if (argument_count >= 3) {
	    newList = argument[2];
	    ds_list_clear(newList);
	} 
	else newList = ds_list_create();

	var pointInString = string_pos(delimiter, oldString);
	var stringLength = string_length(delimiter);

	if (stringLength) while (pointInString) {
	    pointInString -= 1;
	    ds_list_add(newList, string_copy(oldString, 1, pointInString));
	    oldString = string_delete(oldString, 1, pointInString + stringLength);
	    pointInString = string_pos(delimiter, oldString);
	}

	ds_list_add(newList, oldString);


	return newList;



}
