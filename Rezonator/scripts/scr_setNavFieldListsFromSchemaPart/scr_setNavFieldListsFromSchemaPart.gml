// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setNavFieldListsFromSchemaPart(schemaFieldList, fullFieldList, navFieldList){
	
	// make sure we got a schema field list
	if (scr_isNumericAndExists(schemaFieldList, ds_type_list)) {
		
		// loop over schema field list and set each one
		var schemaFieldListSize = ds_list_size(schemaFieldList);
		for (var i = 0; i < schemaFieldListSize; i++) {
			var currentField = schemaFieldList[| i];
			
			// make sure the field is an actual field in the full field list
			if (ds_list_find_index(fullFieldList, currentField) >= 0) {
				ds_list_set(navFieldList, i, currentField);
			}
		}
	}

}