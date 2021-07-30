// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_linkTagOptions(optionSelected){

	var linkSubMap = global.treeMap[? obj_panelPane.functionTree_treeLinkSelected];
	if (!scr_isNumericAndExists(linkSubMap, ds_type_map)) exit;
	var linkTagMap = linkSubMap[? "tagMap"];
	if (!scr_isNumericAndExists(linkTagMap, ds_type_map)) exit;
	
	linkTagMap[? obj_control.linkFieldSelected] = optionSelected;
	
	with (obj_dropDown) instance_destroy();

}