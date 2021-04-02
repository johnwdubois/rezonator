// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_dialogueBoxNewCustomTagChain(){
	
	// get field and make sure it exists
	var fieldToChange = obj_control.chain1to1FieldToChange;
	var fieldSubMap = ds_map_find_value(global.chainFieldMap, fieldToChange);
	if (!is_numeric(fieldSubMap)) exit;
	if (!ds_exists(fieldSubMap, ds_type_map)) exit;
	var newTag = string(obj_control.inputText);
	
	show_debug_message("scr_dialogueBoxNewCustomTagChain() ... fieldToChange: " + string(fieldToChange) + ", newTag: " + string(newTag));
	
	// get this field's tag set and make sure it exists
	var tagSet = ds_map_find_value(fieldSubMap, "tagSet");
	if (!is_numeric(tagSet)) exit;
	if (!ds_exists(tagSet, ds_type_list)) exit;
	
	// add the new tag to the tagSet
	ds_list_insert(tagSet, ds_list_size(tagSet) - 2, newTag);
	
	// set the chain with the new tag
	scr_chain1To1TagOptions(newTag);
	
}