// Credit to Suspendee Studios

var netbuf = buffer_create(1024,buffer_grow,1);
buffer_seek(netbuf,buffer_seek_start,0);
var temptxt = argument1;
var tempmap = ds_map_create();
if (is_string(argument1)) {
	tempmap[? argument0] = argument1;
}
else {
	ds_map_add_map(tempmap,argument0,argument1);
}

buffer_write(netbuf,buffer_text,json_encode(tempmap) + global.splitter);

if (string_pos(global.splitter,temptxt) == 0) {
	network_send_raw(global.server,netbuf,buffer_tell(netbuf));
}
buffer_delete(netbuf);
ds_map_destroy(tempmap);