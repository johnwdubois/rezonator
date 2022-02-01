/// @description set nav window tag
if (!instance_exists(obj_control)) exit;

with(obj_control){
	mouseoverInputBox = false;
}
with (obj_dropDown) {
	if (optionCurrent == -1) {
		show_debug_message("inputBox destroy: destroying dropDown");
		instance_destroy();
	}
}

obj_control.navWindowTaggingFocusHeavy = false;


// get navWindowTagging vars, check if they have any actual values
var setID = obj_control.navWindowTaggingID;
var field = obj_control.navWindowTaggingField;
var tag = str;

// check if we're reverting back to an old tag
if (obj_control.navWindowTaggingEscape) {
	tag = obj_control.navWindowTaggingOldValue;
	obj_control.navWindowTaggingEscape = false;
	obj_control.navWindowTaggingOldValue = "";
}

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
if (!keyboard_check_pressed(vk_left) && !keyboard_check_pressed(vk_right) && !keyboard_check_pressed(vk_up) && !keyboard_check_pressed(vk_down)
&& !keyboard_check_pressed(vk_enter) && !keyboard_check_pressed(vk_escape) && !obj_control.navWindowTaggingSingleOptionSelect) {
	show_debug_message("inputBox destroy, clearing values");
	obj_control.navWindowTaggingID = "";
	obj_control.navWindowTaggingField = "";
}
keyboard_lastchar = "";

obj_control.navWindowTaggingSingleOptionSelect = false;