

function scr_removeFromTagSetOptions(optionSelected, type) {
	
	// determine tagMap based on type
	var tagMap = -1;
	if (type == "token") tagMap = global.nodeMap[? "tokenTagMap"];
	else if (type == "unit") tagMap = global.nodeMap[? "unitTagMap"];
	else if (type == "entry") tagMap = global.entryFieldMap;
	else if (type == "chain") tagMap = global.chainFieldMap;
	else if (type == "chunk") tagMap = global.nodeMap[? "tokenTagMap"];
	else if (type == "link") tagMap = global.nodeMap[? "linkTagMap"];
	if (!scr_isNumericAndExists(tagMap, ds_type_map)) exit;
	
	// determine fieldToChange and tagSubMap based on type
	var fieldToChange = "";
	if (type == "token") {
		fieldToChange = obj_control.tokenFieldToChange;
		with (obj_panelPane) functionField_tokenTagSelected = "";
	}
	else if (type == "unit") {
		fieldToChange = obj_control.unitFieldToChange;
		with (obj_panelPane) functionField_unitTagSelected = "";
	}
	else if (type == "entry") {
		fieldToChange = obj_control.chain1toManyFieldToChange;
		with (obj_panelPane) functionField_entryTagSelected = "";
	}
	else if (type == "chain") {
		fieldToChange = obj_control.chain1to1FieldToChange;
		with (obj_panelPane) functionField_chainTagSelected = "";
	}
	else if (type == "chunk") {
		fieldToChange = obj_control.tokenFieldToChange;
		with (obj_panelPane) functionField_chunkTagSelected = "";
		show_debug_message(string(fieldToChange));
	}
	else if (type == "link") {
		fieldToChange = obj_control.tokenFieldToChange;
		with (obj_panelPane) functionField_linkTagSelected = "";
		show_debug_message(string(fieldToChange));
	}
	var tagSubMap = tagMap[? fieldToChange];
	if (!scr_isNumericAndExists(tagSubMap, ds_type_map)) exit;
	
	// get tagSet for selected field
	var tagSet = tagSubMap[? "tagSet"];
	if (!scr_isNumericAndExists(tagSet, ds_type_list)) exit;
	show_debug_message("scr_removeFromTagSetOptions ... tagSet: " + scr_getStringOfList(tagSet));
	
	// remove the tag from the tagSet
	scr_deleteFromList(tagSet, optionSelected);
	
}