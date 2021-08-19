// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_dialogueBoxNewCustomTagEntry(){
	
	// get field and make sure it exists
	var fieldToChange = obj_control.chain1toManyFieldToChange;
	var fieldSubMap = global.entryFieldMap[? fieldToChange];
	if (!scr_isNumericAndExists(fieldSubMap, ds_type_map)) exit;
	var newTag = string(obj_control.inputText);
	
	show_debug_message("scr_dialogueBoxNewCustomTagEntry() ... fieldToChange: " + string(fieldToChange) + ", newTag: " + string(newTag));
	
	// get this field's tag set and make sure it exists
	var tagSet = fieldSubMap[? "tagSet"];
	if (!scr_isNumericAndExists(tagSet, ds_type_list)) exit;
	
	// add the new tag to the tagSet
	scr_addToListOnce(tagSet, newTag);
	
	
}