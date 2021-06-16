// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chunk1To1TagOptions(optionSelected){
	
	show_debug_message("scr_chunk1To1TagOptions, optionSelected: " + string(optionSelected));
	
	// get chunk's submap and make sure it exists
	var chunkSubMap = global.nodeMap[? obj_control.chunk1to1ChunkToChange];
	if (!scr_isNumericAndExists(chunkSubMap, ds_type_map)) exit;
	var chunkTagMap = chunkSubMap[? "tagMap"];
	if (!scr_isNumericAndExists(chunkTagMap, ds_type_map)) exit;
	
	// set the chunk tag
	chunkTagMap[? obj_control.chunk1to1FieldToChange] = optionSelected;
	
}