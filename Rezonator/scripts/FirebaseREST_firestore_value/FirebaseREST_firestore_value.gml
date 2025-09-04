function FirebaseREST_firestore_value(value, dsType) 
{
	
	// https://firebase.google.com/docs/firestore/reference/rest/v1/Value
	
	var isMap = (dsType == ds_type_map);
	var isList = (dsType == ds_type_list);
	//show_debug_message("FirebaseREST_firestore_value, value: " + string(value) + ", isMap: " + string(isMap) + ", isList: " + string(isList));
	
	var map = ds_map_create()
	if (is_real(value)) {
		
		
		if (isMap) {

			var map_keys = ds_map_create();
			var key = ds_map_find_first(value);
			while (!is_undefined(key)) {
			//	show_debug_message("FirebaseREST_firestore_value, key: " + string(key));
		
				var subValue = value[? key];
				//show_debug_message("FirebaseREST_firestore_value, isMap, subValue: " + string(subValue));
				var subKey = (is_string(subValue)) ? "stringValue" : "doubleValue";
				var keyMap = ds_map_create();
				
				if (ds_map_is_map(value, key)) {
				///	show_debug_message("buhbuh mappy!");
					
					var mapValueMap = ds_map_create();
					var valuesMap = ds_map_create();
					var subValueCurrentKey = ds_map_find_first(subValue);
					while (!is_undefined(subValueCurrentKey)) {
						var currentValueMap = ds_map_create();
						var currentSubValueValue = subValue[? subValueCurrentKey];
						var currentValueMapKey = is_string(currentSubValueValue) ? "stringValue" : "doubleValue";
						currentValueMap[? currentValueMapKey] = currentSubValueValue;
						ds_map_add_map(valuesMap, subValueCurrentKey, currentValueMap);
						subValueCurrentKey = ds_map_find_next(subValue, subValueCurrentKey);
					}
					ds_map_add_map(mapValueMap, "fields", valuesMap);
					ds_map_add_map(keyMap, "mapValue", mapValueMap);
					
					
				}
				else if (ds_map_is_list(value, key)) {
				//	show_debug_message("listo: " + scr_getStringOfList(subValue));

					var arrayValueMap = ds_map_create();
					var valuesList = ds_list_create();
					var listSize = ds_list_size(subValue);
					for (var i = 0; i < listSize; i++) {
						var currentValueMap = ds_map_create();
						currentValueMap[? "stringValue"] = string(subValue[| i]);
						ds_list_add(valuesList, currentValueMap);
						ds_list_mark_as_map(valuesList, i);
					}
					ds_map_add_list(arrayValueMap, "values", valuesList);
					ds_map_add_map(keyMap, "arrayValue", arrayValueMap);
					
					
					/*
					var newMap = FirebaseREST_Firestore_jsonEncode(json_encode(subValue));
					var newMapDecode = json_decode(newMap);
					var newMapKey = ds_map_find_first(newMapDecode);
					var newSubMap = newMapDecode[? newMapKey];
					show_debug_message("newMap: " + string(newMap) + ", newMapKey: " + string(newMapKey));
					show_debug_message("newSubMap: " + string(json_encode(newSubMap)));
					ds_map_add_map(keyMap, subKey, newSubMap);
					*/
					
					//ds_map_add_list(keyMap, subKey, json_decode(newMap));
					//ds_map_add_list(keyMap, subKey, subValue);
				}
				else {
					ds_map_add(keyMap, subKey, subValue);
				}
				
				
				
				ds_map_add_map(map_keys, key, keyMap);
				
				key = ds_map_find_next(value, key);
			}

			var map_field = ds_map_create();
			ds_map_add_map(map_field,"fields",map_keys);
			var json_send = json_encode(map_field);
			//show_debug_message("FirebaseREST_firestore_value map, json_send: " + string(json_send));
			ds_map_destroy(map_field);
		
			ds_map_add(map, "mapValue", json_send);
			
		}
		else if (isList) {
			
			//show_debug_message("isList!!, listvalue: " + scr_getStringOfList(value));
			
			var list_keys = ds_list_create();
			var listSize = ds_list_size(value);
			for (var i = 0; i < listSize; i++) {
				var subValue = value[| i];
				//show_debug_message("FirebaseREST_firestore_value, isList, subValue: " + string(subValue));
				var subKey = (is_string(subValue)) ? "stringValue" : "doubleValue";
				var keyMap = ds_map_create();
				
				
				if (ds_list_is_map(value, i)) {
					show_debug_message("isList mappy!");
					subKey = "mapValue";
					var newMap = FirebaseREST_Firestore_jsonEncode(json_encode(subValue));
					//show_debug_message("newMap: " + string(newMap));
					ds_map_add_map(keyMap, subKey, json_decode(newMap));
				}
				else {
					ds_map_add(keyMap, subKey, subValue);
				}

				ds_list_add(list_keys, keyMap);
				ds_list_mark_as_map(list_keys, ds_list_size(list_keys) - 1);
			}
			
			var map_field = ds_map_create();
			ds_map_add_list(map_field,"values",list_keys);
			var json_send = json_encode(map_field);
			//show_debug_message("FirebaseREST_firestore_value list, json_send: " + string(json_send));
			ds_map_destroy(map_field);
			ds_map_add(map, "arrayValue", json_send);
			
			
		}
		else {
			ds_map_add(map, "integerValue", value)
		}

	}
	else {
		ds_map_add(map, "stringValue", value)
	}

	return map
}
