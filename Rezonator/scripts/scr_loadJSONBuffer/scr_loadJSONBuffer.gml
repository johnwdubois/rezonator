//Credit goes to Juju Adams

var fileName = argument0;

var buffer = buffer_load(fileName);
var bufferString = buffer_read(buffer, buffer_string);
buffer_delete(buffer);

var json = json_decode(bufferString);
return json;