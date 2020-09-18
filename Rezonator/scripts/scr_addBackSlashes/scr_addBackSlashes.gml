function scr_addBackSlashes() {
	var oldString = argument[0];

	var newString = oldString;
	var placeInNewString = 0;

	for (var placeInOldString = 0; placeInOldString < string_length(oldString); placeInOldString++){
		if (string_char_at(oldString, placeInOldString) == "\\"){
		newString = string_insert("\\", newString, placeInNewString);
		show_message(string(placeInOldString) + string(placeInNewString) + newString);
		placeInNewString ++;
		}
		if(placeInOldString != string_length(oldString)-1){
		placeInNewString++;
		}
	}
	show_message("please"+newString)
	return newString;



}
