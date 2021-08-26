// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_linkTagOptions(optionSelected){

	if(optionSelected == "msg_create_tag"){
		obj_control.newCustomTagLink = true;
		obj_control.dialogueBoxActive = true;
		obj_control.tokenFieldToChange = obj_control.linkFieldSelected;
								
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	}
	else{
		var linkSubMap = global.treeMap[? obj_panelPane.functionTree_treeLinkSelected];
		if (!scr_isNumericAndExists(linkSubMap, ds_type_map)) exit;
		var linkTagMap = linkSubMap[? "tagMap"];
		if (!scr_isNumericAndExists(linkTagMap, ds_type_map)) exit;
		linkTagMap[? obj_control.linkFieldSelected] = optionSelected;
		with(obj_panelPane){
			functionField_linkFieldSelected = obj_control.linkFieldSelected;
			functionField_linkTagSelected = optionSelected;
		}
	}
	with (obj_dropDown) instance_destroy();
	

}