function scr_saveFileBuffer(fileNameWD, fileNameUser, stringToSave) {
	//Credit goes to Juju Adams
	// Specify the name and location of the saved file

	var buffer = buffer_create(string_byte_length(stringToSave) + 1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, stringToSave);
	buffer_save(buffer, fileNameUser);
	buffer_delete(buffer);



}
