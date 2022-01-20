/// @description set nav window tag
var setID = obj_control.navWindowTaggingID;
var field = obj_control.navWindowTaggingField;
var tag = str;
show_debug_message("obj_inputbox destroy, ID: " + string(setID));
show_debug_message("obj_inputbox destroy, field: " + string(field));
show_debug_message("obj_inputbox destroy, tag: " + string(tag));

var idSubMap = global.nodeMap[? setID];
if (scr_isNumericAndExists(idSubMap, ds_type_map)) {
	var tagMap = idSubMap[? "tagMap"];
	if (scr_isNumericAndExists(tagMap, ds_type_map)) {
		tagMap[? field] = tag;
	}
}
global.inputBoxDefStr = "";