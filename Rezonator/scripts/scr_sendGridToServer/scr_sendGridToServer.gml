var grid = argument0;

var rootList = ds_list_create();

var map = ds_map_create();
ds_list_add(rootList, map);
ds_list_mark_as_map(rootList, ds_list_size(rootList) - 1);





var mapGrid = scr_gridToJSONLists(grid);
ds_map_add_list(map, scr_getGridNameString(grid), mapGrid);


var wrapper = ds_map_create();
ds_map_add_list(wrapper, "ROOT", rootList);

var jsonString = json_encode(wrapper);

show_message("Finished JSON string");

ip = get_string("Type in IP", "");
port = real(get_string("Type in port", ""));

scr_networkEmit("position", jsonString);


ds_map_destroy(wrapper);