/// @description set nav window tag
if (!instance_exists(obj_control)) exit;

// get navWindowTagging vars, check if they have any actual values
var setID = obj_control.navWindowTaggingID;
var field = obj_control.navWindowTaggingField;
var tag = str;
if (setID == "" || field == "" || !is_string(setID) || !is_string(field)) {
	exit;
}
show_debug_message("obj_inputbox destroy, ID: " + string(setID));
show_debug_message("obj_inputbox destroy, field: " + string(field));
show_debug_message("obj_inputbox destroy, tag: " + string(tag));

// set tag value in map
var idSubMap = global.nodeMap[? setID];
if (scr_isNumericAndExists(idSubMap, ds_type_map)) {
	var tagMap = idSubMap[? "tagMap"];
	if (scr_isNumericAndExists(tagMap, ds_type_map)) {
		tagMap[? field] = tag;
	}
}

// clear the navWindowTagging variables
global.inputBoxDefStr = "";
obj_control.navWindowTaggingID = "";
obj_control.navWindowTaggingField = "";