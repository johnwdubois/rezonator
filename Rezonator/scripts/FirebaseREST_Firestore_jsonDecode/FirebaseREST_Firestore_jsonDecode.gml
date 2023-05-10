
//TODO? yyundefined aparently do the work correctly, Check Obj_FirebaseREST_Listener_On_firestore_document -> HTTP Event
function FirebaseREST_Firestore_jsonDecode(json_data)
{
	//fields -> Key -> stringValue,integerValue,doubleValue -> value

	if(is_undefined(json_data) or json_data == "")
		return json_stringify({yyundefined1:"yyundefined1"})

	var map = ds_map_create()
	var map_data = json_decode(json_data)

	if(!ds_exists(map_data,ds_type_map))
	{
		ds_map_destroy(map)
		return json_stringify({yyundefined2:"yyundefined2"})
	}

	if(ds_map_exists(map_data,"error"))
	{
		var map_error = map_data[?"error"]
		if(map_error[?"code"] == 404)
		{
			ds_map_destroy(map_data)
			ds_map_destroy(map)
			return json_stringify({yyundefined3:"yyundefined3"})
		}
	}
	
	
	if(!ds_map_exists(map_data,"fields"))
	{
		ds_map_destroy(map)
		ds_map_destroy(map_data)
		return json_stringify({yyundefined4:"yyundefined4"})
	}
	

	var map_fields = map_data[?"fields"]
	var key = ds_map_find_first(map_fields)
	while(!is_undefined(key)) {
		var map_value = map_fields[? key];
		
		// check if map_value is a list
		var _firstKey = ds_map_find_first(map_value);
		var value = map_value[? _firstKey];
		if (ds_map_is_list(map_fields, key)) {
			value = map_value[| 0];
		}
	
		// check if the value is an integer or double
		var isNumber = false;
		if (_firstKey == "doubleValue" || _firstKey == "integerValue") {
			isNumber = true;
			value = real(value);
		}
		
		// if value is a string/number
		if (is_string(value) || isNumber) {
			ds_map_add(map, key, value);
		}
		else {

			value = FirebaseREST_parse(value);
			var strToCheck = json_encode(value);
		
			if (strToCheck == "") {
				// if value is a number
				ds_map_add(map, key, value);
			}
			else {
				// if value is a list or map
				var firstKey = ds_map_find_first(value);
				var subValue = value[?firstKey];
				if (firstKey == "List") {
					ds_map_add_list(map,key,subValue);
					
					// subValue is a list, so let's loop through it and see if it contains any maps
					var subValueSize = ds_list_size(subValue);
					for (var i = 0; i < subValueSize; i++) {
						var subSubValue = subValue[| i];
						if (ds_list_is_map(subValue, i)) {
							var subSubValueJsonEncode = json_encode(subSubValue);
							if (subSubValueJsonEncode != "") {
								var recursion = FirebaseREST_Firestore_jsonDecode(subSubValueJsonEncode);
								subValue[| i] = json_decode(recursion);
								ds_list_mark_as_map(subValue, i);
							}
						}
					}

				}
				else if (scr_isNumericAndExists(subValue, ds_type_map)) {
					

					// subValue is a map, so let's loop through it and see if it contains any maps or lists
					var keyList = scr_getKeyListFromMap(subValue);
					var keyListSize = ds_list_size(keyList);
					
					for (var i = 0; i < keyListSize; i++) {
						
						var subKey = keyList[| i];
						var subSubValue = subValue[? subKey];
						if (ds_map_is_map(subValue, subKey)) {
							var subSubValueJsonEncode = json_encode(subSubValue);
							if (subSubValueJsonEncode != "") {
								if (ds_map_exists(subSubValue, "fields")) {
									// subSubValue is a map containing a map
									var recursion = FirebaseREST_Firestore_jsonDecode(subSubValueJsonEncode);
									ds_map_delete(subValue, subKey);
									ds_map_add_map(subValue, subKey, json_decode(recursion));
								}
								else {
									
									ds_map_delete(subValue, subKey);
									
									var _parseValue = FirebaseREST_parse(subSubValue);
									if (scr_isNumericAndExists(_parseValue, ds_type_map)) {
										var _parseValueList = _parseValue[? "List"];
										if (scr_isNumericAndExists(_parseValueList, ds_type_list)) {
											ds_map_add_list(subValue, subKey, _parseValueList);
										}
										else ds_map_add_list(subValue, subKey, ds_list_create());
									}
								}
							}
						}
					}
					
					ds_list_destroy(keyList);
					ds_map_add_map(map,key,subValue);
				}
			}
		}

		key = ds_map_find_next(map_fields,key);
	}

	ds_map_destroy(map_data);

	var json = json_encode(map);
	ds_map_destroy(map);

	return(json)
}

