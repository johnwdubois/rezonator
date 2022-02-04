function scr_navWindowGetTagValue(){
	
	var value = "";

	// get current tag value
	if (obj_control.navWindowTaggingField != "" && obj_control.navWindowTaggingID != "") {
		var idSubMap = global.nodeMap[? obj_control.navWindowTaggingID];
		if (scr_isNumericAndExists(idSubMap, ds_type_map)) {
			var idTagMap = idSubMap[? "tagMap"];
			if (scr_isNumericAndExists(idTagMap, ds_type_map)) {
				if (ds_map_exists(idTagMap, obj_control.navWindowTaggingField)) value = idTagMap[? obj_control.navWindowTaggingField];
			}
		}
	}
	
	return value;

}