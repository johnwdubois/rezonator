// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chainContents1ToManyTagOptions(optionSelected){
	
	// check to see if the user is trying to create a new tag
	if (optionSelected == "Add to tag set") {
		obj_control.newCustomTagEntry = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		exit;
	}
	
	// make sure entry exists in nodeMap and get its submap
	var entryToChange = obj_control.chain1toManyEntryToChange;
	var fieldToChange = obj_control.chain1toManyFieldToChange;
	show_debug_message("scr_chainContents1ToManyTagOptions() ... changing entry: " + string(entryToChange) + " field: " + string(fieldToChange) + " to option: " + string(optionSelected));
	var entrySubMap = ds_map_find_value(global.nodeMap, entryToChange);
	if (!is_numeric(entrySubMap)) exit;
	if (!ds_exists(entrySubMap, ds_type_map)) exit;
	
	// get this entry's tagmap
	var entryTagMap = ds_map_find_value(entrySubMap, "tagMap");
	if (!is_numeric(entryTagMap)) exit;
	if (!ds_exists(entryTagMap, ds_type_map)) exit;
	
	
	if (optionSelected == "Remove tag") {
		// if user selected "Remove tag" then we delete the tag from this entry's tagmap
		ds_map_delete(entryTagMap, fieldToChange);
	}
	else {
		// set the selected tag in this entry's tagmap
		scr_setMap(entryTagMap, fieldToChange, optionSelected);
	}
	
}