function FirebaseREST_parse(value){
	
	var valueEncode = json_encode(value);
	//show_debug_message("scr_parseValue, value:  " + string(value));
	if (valueEncode == "") return value;
	//show_debug_message("scr_parseValue, valueEncode: " + string(valueEncode));
	
	

	var fieldsKey = ds_map_find_first(value);
	var fields = value[? fieldsKey];
	//show_debug_message("fields: " + scr_getStringOfList(fields) + ", fieldsKey:  " + string(fieldsKey))
	var wrapperMap = ds_map_create();
	var fieldMap = ds_map_create();
	var list = ds_list_create();
	if (is_string(fieldsKey)) {
		if (fieldsKey == "values") {
			var fieldListSize = ds_list_size(fields);
			for(var i = 0 ; i < fieldListSize; i++){
				var currentValue = fields[|i];
				var subKey = ds_map_find_first(currentValue);
				var subValue = currentValue[?subKey];
				//show_debug_message("subKey: " + string(subKey) + ", subValue: "+ string(subValue));
			
				if (subKey == "integerValue" || subKey == "doubleValue") subValue = real(subValue);
			
				ds_list_add(list,subValue);
			
				if (subKey == "mapValue") {
					ds_list_mark_as_map(list, ds_list_size(list) - 1);
				}
				else if (subKey == "arrayValue") {
					ds_list_mark_as_list(list, ds_list_size(list) - 1);
				}


			}
			ds_map_add_list(wrapperMap,"List", list);

		}
		else {
		
			var key = ds_map_find_first(fields)
			while(!is_undefined(key))
			{
				var keyValue = fields[?key];
		
				var keySubKey = ds_map_find_first(keyValue);
				var keySubValue = keyValue[?keySubKey];
		
				//show_debug_message("Key: "+ string(key)+"   ,keySubValue:  "+ string(keySubValue) + ", ds_map_is_list(keyValue, keySubKey): " + string(ds_map_is_list(keyValue, keySubKey)));
			
				if (ds_map_is_map(keyValue, keySubKey)) {
					ds_map_add_map(fieldMap, key, keySubValue);
				}
				else if (ds_map_is_list(keyValue, keySubKey)) {
					ds_map_add_list(fieldMap, key, keySubValue);
				}
				else {
					ds_map_add(fieldMap, key, keySubValue);
				}
		
				key = ds_map_find_next(fields,key);
			}
			ds_map_add_map(wrapperMap,"Map", fieldMap);

		}
	}
	return wrapperMap;

}