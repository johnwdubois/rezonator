//Credit goes to Juju Adams

var fileNameWD = argument0;
var fileNameUser = argument1;
var stringToSave = argument2;

var buffer = buffer_create(string_byte_length(stringToSave) + 1, buffer_fixed, 1);
buffer_write(buffer, buffer_string, stringToSave);
buffer_save_ns(buffer, fileNameWD);
buffer_save_ns(buffer, fileNameUser);
buffer_delete(buffer);

//file_copy_ns(fileNameWD, fileNameUser);

show_debug_message(filename_path(fileNameWD));

/*
var dirName = filename_path(global.fileSaveName) + string_lettersdigits(filename_name(global.fileSaveName)) + " BoyBoys";

if (not directory_exists_ns(dirName)) {
	directory_create_ns(dirName);
}

file_copy_ns(fileNameWD, dirName + "/maybe.rez");