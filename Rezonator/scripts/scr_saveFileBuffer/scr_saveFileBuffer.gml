function scr_saveFileBuffer(argument0, argument1, argument2) {
	//Credit goes to Juju Adams
	// Specify the name and location of the saved file

	var fileNameWD = argument0;
	var fileNameUser = argument1;
	var stringToSave = argument2;

	var buffer = buffer_create(string_byte_length(stringToSave) + 1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, stringToSave);
	buffer_save(buffer, fileNameUser);
	buffer_delete(buffer);

	//show_debug_message(filename_path(fileNameWD));


}
