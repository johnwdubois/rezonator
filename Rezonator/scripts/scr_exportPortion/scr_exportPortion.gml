// Save a Rez file containing a user specified collection of lines

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



obj_fileLoader.subLineGridBeginning = string_digits(ds_list_find_value(obj_control.listOfNumbers, 0));
obj_fileLoader.subLineGridEnd = string_digits(ds_list_find_value(obj_control.listOfNumbers, 1));

global.stackGrabSave = true;

//show_message(obj_fileLoader.subLineGridBeginning);
//show_message(obj_fileLoader.subLineGridEnd);



scr_saveREZ(false);