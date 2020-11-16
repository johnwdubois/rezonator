function scr_sendGridToServer(argument0) {
	// Experimental function for sending a grid to an online server

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

	show_message(scr_get_translation("msg_Json-finished"));


	scr_networkEmit("position", jsonString);




	ds_map_destroy(wrapper);


}
