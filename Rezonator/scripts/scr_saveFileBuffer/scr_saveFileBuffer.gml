//Credit goes to Juju Adams

var fileName = argument0;
var stringToSave = argument1;

var buffer = buffer_create(string_byte_length(stringToSave) + 1, buffer_fixed, 1);
buffer_write(buffer, buffer_string, stringToSave);
buffer_save(buffer, fileName);
buffer_delete(buffer);

show_debug_message(filename_path(fileName));