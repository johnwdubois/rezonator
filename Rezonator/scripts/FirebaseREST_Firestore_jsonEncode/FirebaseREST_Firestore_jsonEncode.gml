function FirebaseREST_Firestore_jsonEncode(json)
{
	//show_debug_message("FirebaseREST_Firestore_jsonEncode, json: " + string(json));
	
	var map = json_decode(json);
	var map_keys = ds_map_create();


	var key = ds_map_find_first(map)
	while (!is_undefined(key))
	{
		//show_debug_message("FirebaseREST_Firestore_jsonEncode, key: " + string(key));
		
		var mapKeyMap = map[? key];
		var dsType = -1;
		
		//show_debug_message("mapKeyMap: " + string(mapKeyMap));
		
		if (!is_string(mapKeyMap)) {
			var mapKeyMapEncode = json_encode(mapKeyMap);
			show_debug_message("mapKeyMap: " + string(mapKeyMap) + ", mapKeyMapEncode: " + string(mapKeyMapEncode));
			//show_debug_message("FirebaseREST_Firestore_jsonEncode, mapKeyMapEncode: " + string(mapKeyMapEncode));
			//if (mapKeyMapEncode != "") {
				if (is_numeric(mapKeyMap)) {
					// check if this is a list or map
					if (ds_map_is_map(map, key)) {
						//show_debug_message("map found!");
						dsType = ds_type_map;
					}
					else if (ds_map_is_list(map, key)) {
						//show_debug_message("list found!");
						dsType = ds_type_list;
					}
				}
			//}
		}
		
		show_debug_message("mapKeyMap: " + string(mapKeyMap) + ", dsType: " + string(dsType));
		var valueMap = FirebaseREST_firestore_value(mapKeyMap, dsType);
		//show_debug_message("FirebaseREST_Firestore_jsonEncode, valueMap: " + json_encode(valueMap));
		
		
		ds_map_add_map(map_keys,key,valueMap);
		key = ds_map_find_next(map,key)
	}
		
	
	ds_map_destroy(map)
	
	var map_field = ds_map_create()
	ds_map_add_map(map_field,"fields",map_keys)
	var json_send = json_encode(map_field)
	ds_map_destroy(map_field)
	

	return json_send
}
